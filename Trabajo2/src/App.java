import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.sql.*;

public class App {
    static boolean insertXml(String[] squares){
        String xml = '
        <locales>
        ';

        for 


    }
    static boolean overlap(String[] squares){
        boolean[][] canvas = new boolean[500][500];
        int x,y,w,h;
        String[] numeros;

        // para cada cuadrado de la lista squares
        for(int i=0; i<squares.length; i++){
            if(squares[i] != ""){
            
                System.out.println(squares[i]);
                // separar el string en las coordenadas x y h w
                numeros = squares[i].split(",");
                x = Integer.parseInt(numeros[0].trim());
                y = Integer.parseInt(numeros[1].trim());
                w = Integer.parseInt(numeros[2].trim());
                h = Integer.parseInt(numeros[3].trim());

                for(int j=x;j<(x+w);j++){
                    for(int k=y;k<(y+h);k++){
                        if(canvas[j][k]){
                            return true;
                        }else{
                            canvas[j][k]=true;
                        }
                    }
                }
            }
        }
        return false;
    }
    static void primero(){
        // construccion de la ventana a mostrar
        JFrame f=new JFrame();//creating instance of JFrame  

        // boton de insertar
        JButton b=new JButton("insertar");//creating instance of JButton  
        b.setBounds(550,250,100,50);//posicion del boton en x e y, tamaño del boton HxW 
        f.add(b);//adding button in JFrame  

        // datos de los locales
        JTextArea mainText = new JTextArea();
        mainText.setBounds(10, 50, 400, 250);
        f.add(mainText);

        // nombre de la ciudad
        JTextArea ciudad = new JTextArea();
        ciudad.setBounds(500, 50, 200, 100);
        f.add(ciudad);

        // agregar titulos a los campos de texto
        JLabel titulo = new JLabel("Ingreso de datos de los locales de una ciudad");
        titulo.setBounds(100,10,400,30);
        f.add(titulo);

        // nombre de la ciudad
        JLabel nombreCiudad = new JLabel("Ingrese el nombre de la ciudad:");
        nombreCiudad.setBounds(520,10,400,30);
        
        // ejecutar cuando se hace click sobre el boton
        b.addActionListener(new ActionListener(){
            public void actionPerformed(ActionEvent ae){
                // cuando se hace click sobre el boton se ejecuta todo este codigo

                // obtener datos de los locales
                String datosLocales = mainText.getText();
                System.out.println("Datos de locales");
                System.out.println(datosLocales);

                // obtener nombre de la ciudad
                String Ciudad = ciudad.getText();
                System.out.println("Nombre de la ciudad");
                System.out.println(Ciudad);
                
                String[] locales = datosLocales.split("\\r?\\n");
                
                if(overlap(locales)){
                    //mostrar error porque los locales se solapan
                    System.out.println("los locales se solapan");
                }else{
                    // todo correcto, guardar datos como xml en base de datos
                    System.out.println("todo correcto");
                }
            }
        });
        f.add(nombreCiudad);
        f.setSize(800,400);//tamaño de la ventana emergente  
        f.setLayout(null);//using no layout managers  
        f.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);// para cerrar la ventana
        f.setVisible(true);//mostrar la ventana creada
    }
    static void segundo(){
        // construccion de la ventana a mostrar
        JFrame f=new JFrame();//creating instance of JFrame  

        // boton de insertar
        JButton b=new JButton("insertar");//creating instance of JButton  
        b.setBounds(475,250,100,50);//posicion del boton en x e y, tamaño del boton HxW 
        f.add(b);//adding button in JFrame  

        // datos de los locales
        JTextArea mainText = new JTextArea();
        mainText.setBounds(20, 75, 250, 200);
        f.add(mainText);

        // nombre de la ciudad
        JTextArea codigo = new JTextArea();
        codigo.setBounds(550, 75, 200, 100);
        f.add(codigo);
        

        // agregar titulos a los campos de texto
        JLabel titulo = new JLabel("Ingreso de datos de las ventas de un vendedor en una ciudad");
        titulo.setBounds(200,5,400,30);
        f.add(titulo);

        // seleccionar ciudad
        // se debe hacer una consulta a la base de datos que retorne todas las ciudades y convertir ese
        // resultado en una lista de strings 
        String[] ciudades = { "Medellín","Cali","Bogotá","Rionegro"}; // estos valores quemados son para hacer prubas
        // los valores reales se deben extraer de manera dinamica de la base de datos

        JComboBox nombreCiudad = new JComboBox(ciudades);
        nombreCiudad.setBounds(320,75,150,30);
        nombreCiudad.setSelectedIndex(0);
        f.add(nombreCiudad);

        // Codigo del vendedor
        JLabel labelCodigo = new JLabel("Código vendedor");
        labelCodigo.setBounds(560,40,400,30);
        f.add(labelCodigo);

        // label ciudad
        JLabel labelCiudad= new JLabel("Seleccione la ciudad:");
        labelCiudad.setBounds(320,40,400,30);
        f.add(labelCiudad);
        
        // ejecutar cuando se hace click sobre el boton
        b.addActionListener(new ActionListener(){
            public void actionPerformed(ActionEvent ae){
                // cuando se hace click sobre el boton se ejecuta todo este codigo

                // obtener datos de los locales
                String datosLocales = mainText.getText();
                System.out.println("Datos de locales");
                System.out.println(datosLocales);

                // obtener nombre de la ciudad
                String Ciudad = (String) nombreCiudad.getSelectedItem();
                System.out.println("Nombre de la ciudad");
                System.out.println(Ciudad);
                
                // obtener codigo de la interfaz
                String Codigo = (String) codigo.getText();
                System.out.println("Código");
                System.out.println(Codigo);
            }
        });

        f.setSize(800,400);//tamaño de la ventana emergente  
        f.setLayout(null);//using no layout managers  
        f.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);// para cerrar la ventana
        f.setVisible(true);//mostrar la ventana creada
    }
    public static void main(String[] args) throws Exception {
        Connection conn;
        Statement sentencia;
        ResultSet resultado;
        try{
            Class.forName("oracle.jdbc.driver.OracleDriver");
        }catch (Exception e){
            System.out.println("No se pudo cargar el driver");
            System.out.println(e);
            return;
        }

        try{
        conn = DriverManager.getConnection("jdbc:oracle:thin:@DESKTOP-PJJQEPL:1521:xe", "david", "yui");
        }catch(SQLException e){
            System.out.println("error de conexion");
            return;
        }

        primero();
    }
}
