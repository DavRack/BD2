drop table proveedor;
drop table venta;
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

DECLARE 
    TYPE lista IS TABLE OF varchar(50) INDEX BY BINARY_INTEGER;
    milista lista;
    
    CURSOR tupla IS
    SELECT distinct codpv, codproducto FROM venta order by codpv;
    codi venta.codpv%TYPE;
    product venta.codproducto%TYPE;
BEGIN
    OPEN tupla;
    LOOP 
    FETCH tupla INTO codi,product;
    EXIT WHEN tupla%NOTFOUND;
    -- generar una lista con los productos que cada vendedor vende
    if milista.exists(codi) then
        milista(codi) := milista(codi) || ',' || cast(product as varchar);
    else
        milista(codi):= cast(product as varchar);
    end if;
    END LOOP;
    
    CLOSE tupla;
END;
/
