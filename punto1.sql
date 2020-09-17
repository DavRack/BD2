drop table proveedor;
drop table venta;
drop table auxtable;

CREATE TABLE proveedor(
codpv NUMBER(8) PRIMARY KEY,
nompv VARCHAR2(10) NOT NULL
);

BEGIN
INSERT INTO proveedor VALUES(10,'Lisy');
INSERT INTO proveedor VALUES(20,'Kirsty');
INSERT INTO proveedor VALUES(30,'Biorky');
INSERT INTO proveedor VALUES(40,'Wimpy');
INSERT INTO proveedor VALUES(50,'Chucky');
INSERT INTO proveedor VALUES(60,'Chubby');
END;
/

CREATE TABLE venta(
idv NUMBER(8) PRIMARY KEY,
codpv NUMBER(8) REFERENCES proveedor NOT NULL,
codproducto NUMBER(8) NOT NULL
);



BEGIN
INSERT INTO venta VALUES(3,10,1);
INSERT INTO venta VALUES(5,10,2);
INSERT INTO venta VALUES(7,10,5);
INSERT INTO venta VALUES(17,10,2);
INSERT INTO venta VALUES(8,20,2);
INSERT INTO venta VALUES(1,20,1);
INSERT INTO venta VALUES(9,20,5);
INSERT INTO venta VALUES(31,20,1);
INSERT INTO venta VALUES(33,20,1);
INSERT INTO venta VALUES(10,30,1);
INSERT INTO venta VALUES(11,30,2);
INSERT INTO venta VALUES(12,40,2);
INSERT INTO venta VALUES(2,40,1);
INSERT INTO venta VALUES(22,40,2);
INSERT INTO venta VALUES(28,50,2);
INSERT INTO venta VALUES(21,50,1);
INSERT INTO venta VALUES(29,50,5);
INSERT INTO venta VALUES(99,60,2);
END;
/
-- Tabla auxiliar necesaria para la ejecución del codigo
CREATE TABLE auxtable(
nombre varchar(20),
idven number(8),
prod varchar(100)
);

CREATE OR REPLACE PROCEDURE grupos
(r in number)
IS
    TYPE lista IS TABLE OF varchar(50) INDEX BY BINARY_INTEGER;
    
    milista lista;
    nombres lista;
    idven lista;
    prod lista;
    
    -- indices de las combinaciones del algoritmo de combinaciones
    indice lista;
    
    counter NUMBER;
    iter2 NUMBER;
    top NUMBER;
    iter Number;
    n Number;
    i NUMBER;
    
    codi venta.codpv%TYPE;
    product venta.codproducto%TYPE;
    nombre proveedor.nompv%TYPE;
    
    nom auxtable.nombre%TYPE;
    venid auxtable.idven%TYPE;
    pro auxtable.prod%TYPE;
    
    -- variable para generar la salida del algoritmo de combinaciones
    output varchar(10000);
    
    proActual varchar(1000);

    
    CURSOR tupla IS
    SELECT DISTINCT proveedor.nompv, venta.codpv, venta.codproducto
    FROM venta JOIN proveedor ON venta.codpv=proveedor.codpv ORDER BY codpv;
    
    CURSOR ventanombre IS
    SELECT nombre,idven,prod FROM auxtable ORDER BY prod;

BEGIN
    OPEN tupla;
    LOOP 
    FETCH tupla INTO nombre,codi,product;
    EXIT WHEN tupla%NOTFOUND;
    -- generar un string con los productos que cada vendedor vende
    IF milista.EXISTS(codi) THEN
        milista(codi) := milista(codi) || ',' || CAST(product AS varchar);
    ELSE
        milista(codi):= CAST(product AS varchar);
        nombres(codi):= nombre;
    END IF;
    END LOOP;
    
    
    i := milista.FIRST;
    -- insertar el nombre del vendedor su id y sus productos en una tabla auxtable
    WHILE i IS NOT NULL LOOP
        INSERT INTO auxtable VALUES(nombres(i),i,milista(i));
        i := milista.NEXT(i);
    END LOOP;
    CLOSE tupla;
    
    proActual:=' ';
    nombres.DELETE;
    idven.DELETE;
    prod.DELETE;
    
    i := 0;
    
    -- de la tabla auxtable insertaremos el nombre, id y lista de productos 
    -- en una lista para cada uno mientras el la lista de productos sea igual
    -- cuando la lista no sea igual esto indica que estamos hablando de
    -- una lista de productos diferentes por lo tanto ejecutamos el algoritmo de combinatoria
    -- y limpiamos las listas para repetir el proceso con la siguiente lista de productos
    OPEN ventanombre;
    LOOP
    FETCH ventanombre INTO nom,venid,pro;
    exit WHEN ventanombre%NOTFOUND;
        IF proActual = pro THEN
            i := i + 1;
            nombres(i) := nom;
            idven(i) := venid;
            prod(i) := pro;
        ELSE
            -- algoritmo de combinatoria, k tomados de a n
            -- r combinatoria
            indice.DELETE;
            n := idven.LAST+1; -- numero de elementos en la lista
            
            FOR iter IN 0..r-1 LOOP
                indice(iter):=iter;
            END LOOP;
            
            iter := r - 1;
            while indice(0)< (n-r+1) LOOP
                while iter > 0 and indice(iter)=(n-r+iter) LOOP
                    iter := iter-1;
                END LOOP;
                -- generar el string a imprimir
                output := '';
                
                FOR k IN indice.FIRST..indice.LAST LOOP
                    output := output || idven(indice(k))||'('||nombres(indice(k))||'),';
                END LOOP;
                output:=TRIM(trailing ',' FROM output); -- eliminar la ultima ',' del string

                -- imprimimos el resultado del computo
                DBMS_OUTPUT.PUT_LINE('['||output||']->{'||proActual||'}');

                indice(iter):= indice(iter)+1;
                while iter < r-1 LOOP
                    indice(iter+1):=indice(iter)+1;
                    iter := iter +1;
                END LOOP;
                
            END LOOP;
            
            proActual := pro;
            nombres.DELETE;
            idven.DELETE;
            prod.DELETE;
            
            nombres(0) := nom;
            idven(0) := venid;
            prod(0) := pro;
            i:=0;
        END IF;
    END LOOP;
    -- algoritmo de combinatoria
    -- se debe ejecutar nuevamente por la naturaleza de la implementación
    indice.DELETE;
    n := idven.LAST+1;
    
    FOR iter IN 0..r-1 LOOP
        indice(iter):=iter;
    END LOOP;
    
    iter := r - 1;
    WHILE indice(0)< (n-r+1) LOOP
        WHILE iter > 0 AND indice(iter)=(n-r+iter) LOOP
            iter := iter-1;
        END LOOP;
        -- generar el string a imprimir
        output := '';
        
        FOR k IN indice.FIRST..indice.LAST LOOP
            output := output || idven(indice(k))||'('||nombres(indice(k))||'),';
        END LOOP;
        output:=TRIM(trailing ',' FROM output);
        DBMS_OUTPUT.PUT_LINE('['||output||']->{'||proActual||'}');
        indice(iter):= indice(iter)+1;
        WHILE iter < r-1 LOOP
            indice(iter+1):=indice(iter)+1;
            iter := iter +1;
        END LOOP;
        
    END LOOP;
    close ventanombre;
END;
/
