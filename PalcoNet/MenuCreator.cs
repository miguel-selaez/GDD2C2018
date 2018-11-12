using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace PalcoNet
{
    public class MenuCreator
    {
        private Inicio _main;

        public MenuCreator(Inicio main)
        {
            _main = main;
        }

        public ToolStripMenuItem GetItemMenu(string funcion)
        {
            ToolStripMenuItem itemMenu = new ToolStripMenuItem();

            switch (funcion) { 
                case "ABM ROL":
                    itemMenu.Text = "Rol";

                    ToolStripMenuItem listadoRol = new ToolStripMenuItem("Listado", null, new EventHandler(listadoRol_Click));
                    itemMenu.DropDownItems.Add(listadoRol);

                    ToolStripMenuItem nuevoRol = new ToolStripMenuItem("Nuevo", null, new EventHandler(nuevoRol_Click));
                    itemMenu.DropDownItems.Add(nuevoRol);
                    break;
                case "ABM USUARIO":
                    itemMenu.Text = "Usuario";
                    ToolStripMenuItem listadoUsuario = new ToolStripMenuItem("Listado", null, new EventHandler(listadoUsuario_Click));
                    itemMenu.DropDownItems.Add(listadoUsuario);

                    ToolStripMenuItem nuevoUsuario = new ToolStripMenuItem("Nuevo", null, new EventHandler(nuevoUsuario_Click));
                    itemMenu.DropDownItems.Add(nuevoUsuario);
                    break;
                case "ABM CLIENTE":
                    itemMenu.Text = "Cliente";
                    ToolStripMenuItem listadoCliente = new ToolStripMenuItem("Listado", null, new EventHandler(listadoCliente_Click));
                    itemMenu.DropDownItems.Add(listadoCliente);

                    ToolStripMenuItem nuevoCliente = new ToolStripMenuItem("Nuevo", null, new EventHandler(nuevoCliente_Click));
                    itemMenu.DropDownItems.Add(nuevoCliente);
                    break;
                case "ABM EMPRESA":
                    itemMenu.Text = "Empresa";
                    ToolStripMenuItem listadoEmpresa = new ToolStripMenuItem("Listado", null, new EventHandler(listadoEmpresa_Click));
                    itemMenu.DropDownItems.Add(listadoEmpresa);

                    ToolStripMenuItem nuevaEmpresa = new ToolStripMenuItem("Nuevo", null, new EventHandler(nuevaEmpresa_Click));
                    itemMenu.DropDownItems.Add(nuevaEmpresa);
                    break;
                case "ABM GRADO":
                    itemMenu.Text = "Grado";
                    ToolStripMenuItem listadoGrado = new ToolStripMenuItem("Listado", null, new EventHandler(listadoGrado_Click));
                    itemMenu.DropDownItems.Add(listadoGrado);

                    ToolStripMenuItem nuevoGrado = new ToolStripMenuItem("Nuevo", null, new EventHandler(nuevoGrado_Click));
                    itemMenu.DropDownItems.Add(nuevoGrado);
                    break;
                case "ABM RUBRO":
                    itemMenu.Text = "Rubro";
                    break;
                case "ABM PUBLICACION":
                    itemMenu.Text = "Publicacion";
                    ToolStripMenuItem listadoPublicacion = new ToolStripMenuItem("Buscar Publicacion", null, new EventHandler(listadoPublicacion_Click));
                    itemMenu.DropDownItems.Add(listadoPublicacion);

                    ToolStripMenuItem nuevaPublicacion = new ToolStripMenuItem("Crear", null, new EventHandler(nuevaPublicacion_Click));
                    itemMenu.DropDownItems.Add(nuevaPublicacion);
                    break;
                case "COMPRAS":
                    itemMenu.Text = "Compras";
                    ToolStripMenuItem listadoCompras = new ToolStripMenuItem("Comprar", null, new EventHandler(nuevaCompra_Click));
                    itemMenu.DropDownItems.Add(listadoCompras);

                    ToolStripMenuItem nuevaCompra = new ToolStripMenuItem("Historial", null, new EventHandler(historialCompras_Click));
                    itemMenu.DropDownItems.Add(nuevaCompra);
                    break;
                case "CANJE Y PUNTOS":
                    itemMenu = new ToolStripMenuItem("Canje", null, new EventHandler(canje_Click));
                    break;
                case "RENDICIONES":
                    itemMenu = new ToolStripMenuItem("Generar Rendiciones", null, new EventHandler(rendiciones_Click));
                    break;
                case "LISTADO ESTADISTICO":
                    itemMenu = new ToolStripMenuItem("Estadísticas", null, new EventHandler(estadisticas_Click));
                    break;
                case "LOGGED":
                    itemMenu.Text = "Archivo";
                    ToolStripMenuItem cerrarSesion = new ToolStripMenuItem("Cerrar Sessión", null, new EventHandler(cerrarSesion_Click));
                    itemMenu.DropDownItems.Add(cerrarSesion);

                    ToolStripMenuItem cerrarL = new ToolStripMenuItem("Cerrar", null, new EventHandler(cerrar_Click));
                    itemMenu.DropDownItems.Add(cerrarL);
                    break;
                default:
                    itemMenu.Text = "Archivo";
                    ToolStripMenuItem iniciarSesion = new ToolStripMenuItem("Iniciar Sesión", null, new EventHandler(iniciarSesion_Click));
                    itemMenu.DropDownItems.Add(iniciarSesion);

                    ToolStripMenuItem cerrarD = new ToolStripMenuItem("Cerrar", null, new EventHandler(cerrar_Click));
                    itemMenu.DropDownItems.Add(cerrarD);
                    break;
            }
           
            ((ToolStripDropDownMenu)(itemMenu.DropDown)).ShowImageMargin = false;
            ((ToolStripDropDownMenu)(itemMenu.DropDown)).ShowCheckMargin = true;

            return itemMenu;
        }

        private void historialCompras_Click(object sender, EventArgs e)
        {
            var historial = new Historial_Cliente.Historial(_main.session);

            historial.Show();
        }

        private void rendiciones_Click(object sender, EventArgs e)
        {
            var rendiciones = new Generar_Rendicion_Comisiones.Rendiciones(_main.session);

            rendiciones.Show();
        }

        private void cerrar_Click(object sender, EventArgs e)
        {
            _main.Close();
        }

        private void cerrarSesion_Click(object sender, EventArgs e)
        {
            _main.session = null;
            _main.MainMenuStrip.Items.Clear();

            _main.SetInitMenu();
        }

        private void iniciarSesion_Click(object sender, EventArgs e)
        {
            _main.OpenLogin();
        }

        private void estadisticas_Click(object sender, EventArgs e)
        {
            var estadisticas = new ListadoEstadistico.Estadisticas(_main.session);
            
            estadisticas.Show();
        }

        private void nuevaCompra_Click(object sender, EventArgs e)
        {
            var nuevo = new Comprar.Compra(_main.session);
            
            nuevo.Show();
        }

        private void canje_Click(object sender, EventArgs e)
        {
            var listado = new Canje_Puntos.Canje(_main.session);
            
            listado.Show();
        }

        private void nuevaPublicacion_Click(object sender, EventArgs e)
        {
            var nuevo = new Generar_Publicacion.Publicacion(_main.session);
            
            nuevo.Show();
        }

        private void listadoPublicacion_Click(object sender, EventArgs e)
        {
            var listado = new Generar_Publicacion.ListadoPublicacion(_main.session);
            
            listado.Show();
        }

        private void nuevoGrado_Click(object sender, EventArgs e)
        {
            var nuevo = new Abm_Grado.Grado(_main.session);
            
            nuevo.Show();
        }

        private void listadoGrado_Click(object sender, EventArgs e)
        {
            var listado = new Abm_Grado.ListadoGrado(_main.session);
            
            listado.Show();
        }

        private void nuevaEmpresa_Click(object sender, EventArgs e)
        {
            var nuevo = new Abm_Empresa_Espectaculo.EmpresaEspectaculo(_main.session);
            
            nuevo.Show();
        }

        private void listadoEmpresa_Click(object sender, EventArgs e)
        {
            var listado = new Abm_Empresa_Espectaculo.ListadoEmpresa(_main.session);
            
            listado.Show();
        }

        private void nuevoCliente_Click(object sender, EventArgs e)
        {
            var nuevo = new AbmCliente.Cliente(_main.session);
            
            nuevo.Show();
        }

        private void listadoCliente_Click(object sender, EventArgs e)
        {
            var listado = new AbmCliente.ListadoCliente(_main.session);
            
            listado.Show();
        }

        private void nuevoUsuario_Click(object sender, EventArgs e)
        {
            var nuevo = new AbmUsuario.Usuario(_main.session);
            
            nuevo.Show();
        }

        private void listadoUsuario_Click(object sender, EventArgs e)
        {
            var listado = new AbmUsuario.ListadoUsuario(_main.session);
            listado.Show();
        }

        private void nuevoRol_Click(object sender, EventArgs e)
        {
            var nuevoRol = new AbmRol.Rol(_main.session);
            nuevoRol.Show();
        }

        private void listadoRol_Click(object sender, EventArgs e)
        {
            var listado = new AbmRol.ListadoRol(_main.session);
            listado.Show();
        }
    }
}
