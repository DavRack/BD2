import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.sql.*;
public class App {
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
            }
        });
        f.add(nombreCiudad);
        f.setSize(800,400);//tamaño de la ventana emergente  
        f.setLayout(null);//using no layout managers  
        f.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);// para cerrar la ventana
        f.setVisible(true);//mostrar la ventana creada
    }
    public static void main(String[] args) throws Exception {
        primero();
    }
}
