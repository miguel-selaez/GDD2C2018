using PalcoNet.Model;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace PalcoNet
{
    public partial class Inicio : Form
    {
        public Session session;

        private MenuCreator _menuCreator;

        public Inicio()
        {
            InitializeComponent();
            _menuCreator = new MenuCreator(this);
            SetInitMenu();
        }

        private void btnLogin_Click(object sender, EventArgs e)
        {
            OpenLogin();
        }

        public void OpenLogin() {
            Hide();
            var login = new Login.Login(this);
            login.Show();
        }

        private void btnClientes_Click(object sender, EventArgs e)
        {
            
        }

        public void SetSession(Usuario user, Hotel hotel, Rol rol)
        {
            session = new Session() { 
                User = user, 
                Main = this,
                Hotel = hotel,
                Rol = rol
            };

            SetLoggedMenu();
        }

        private void SetLoggedMenu()
        {
            this.MainMenuStrip.Items.Clear();
            var itemDefault = _menuCreator.GetItemMenu("LOGGED");
            mainMenu.MdiWindowListItem = itemDefault;
            mainMenu.Items.Add(itemDefault);

            foreach (var funcion in session.Rol.Funciones)
            {
                var itemFuncion = _menuCreator.GetItemMenu(funcion.Descripcion);
                mainMenu.MdiWindowListItem = itemFuncion;
                mainMenu.Items.Add(itemFuncion);
            }   

            mainMenu.Dock = DockStyle.Top;
            this.MainMenuStrip = mainMenu;
        }

        public void SetInitMenu() {
            var itemDefault = _menuCreator.GetItemMenu("INIT");
            mainMenu.MdiWindowListItem = itemDefault;
            mainMenu.Items.Add(itemDefault);

            mainMenu.Dock = DockStyle.Top;
            this.MainMenuStrip = mainMenu;

            var generico = DAO.DAOFactory.UsuarioDAO.Login("generico", "gen123*");
            SetSession(generico, null, generico.Roles.First());
            SetLoggedMenu();
        }
    }
}
