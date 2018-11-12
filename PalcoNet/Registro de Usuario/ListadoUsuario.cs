using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace PalcoNet.AbmUsuario
{
    public partial class ListadoUsuario : Form
    {
        private Model.Session _session;
        private List<Model.Usuario> _results;

        public ListadoUsuario(Model.Session _session)
        {
            this._session = _session;
            InitializeComponent();
            InitValues();
        }

        private void InitValues()
        {
            cbVigencia.SelectedIndex = 0;
        }

        public List<Model.Usuario> GetResults()
        {
            return DAOFactory.UsuarioDAO.GetUsuarios(txtUsuario.Text, cbVigencia.SelectedItem.ToString());
        }

        private void dgUsuarios_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            var selectedUsuario = _results.ElementAt(e.RowIndex);
            var nuevo = new Usuario(_session, selectedUsuario, this);
            nuevo.Show();
        }

        private void btnBuscar_Click(object sender, EventArgs e)
        {
            dgUsuarios.Rows.Clear();
            _results = GetResults();

            foreach (Model.Usuario usuario in _results)
            {
                var index = dgUsuarios.Rows.Add();
                dgUsuarios.Rows[index].Cells["Usuario"].Value = usuario.NombreUsuario;
                dgUsuarios.Rows[index].Cells["Nombre"].Value = usuario.Persona.Nombre;
                dgUsuarios.Rows[index].Cells["Apellido"].Value = usuario.Persona.Apellido;
                dgUsuarios.Rows[index].Cells["Vigente"].Value = usuario.Baja ? "No" : "Si";
                dgUsuarios.Rows[index].Cells["Editar"].Value = "Seleccionar";
            }
        }

        private void btnLimpiar_Click(object sender, EventArgs e)
        {
            txtUsuario.Text = "";
            cbVigencia.SelectedIndex = 0;
        }

        public void UpdateUsuarios()
        {
            btnBuscar.PerformClick();
        }
    }
}
