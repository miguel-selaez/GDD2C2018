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

namespace PalcoNet.Login
{
    public partial class LoginSeleccion : Form
    {
        private Inicio _inicio;
        private Usuario _user;

        public LoginSeleccion(Inicio inicio, Usuario user)
        {
            InitializeComponent();
            _inicio = inicio;
            _user = user;

            BindRoles();
        }

        private void BindRoles()
        {
            cbRoles.DataSource = null;
            cbRoles.DataSource = _user.Roles;
            cbRoles.DisplayMember = "Descripcion";
            cbRoles.SelectedIndex = 0;
        }

        private void btnContinue_Click(object sender, EventArgs e)
        {
            var selectedRol = (Model.Rol) cbRoles.SelectedValue;
            _inicio.SetSession(_user, selectedRol);
            _inicio.Show();
            Close();
        }

        private void lbRol_Click(object sender, EventArgs e)
        {

        }
    }
}
