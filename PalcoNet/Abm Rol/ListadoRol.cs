using PalcoNet.DAO;
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

namespace PalcoNet.AbmRol
{
    public partial class ListadoRol : Form
    {
        private Session _session;
        private List<Model.Rol> _results;

        public ListadoRol(Session session)
        {
            InitializeComponent();
            _session = session;
            InitValues();
        }

        private void InitValues()
        {
            cbVigencia.SelectedIndex = 0;
        }

        public List<Model.Rol> GetResults() {
            return DAOFactory.RolDAO.GetRoles(txtDescripcion.Text, cbVigencia.SelectedItem.ToString());
        }

        private void btnBuscar_Click(object sender, EventArgs e)
        {
            dgRoles.Rows.Clear();
            _results = GetResults();

            foreach (Model.Rol rol in _results)
            {
                var index = dgRoles.Rows.Add();
                dgRoles.Rows[index].Cells["Descripcion"].Value = rol.Descripcion;
                dgRoles.Rows[index].Cells["Vigente"].Value = rol.Baja ? "No" : "Si";
                dgRoles.Rows[index].Cells["Editar"].Value = "Seleccionar";
            }
        }

        private void dgRoles_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            var selectedRol = _results.ElementAt(e.RowIndex);
            var nuevo = new Rol(_session, selectedRol, this);
            nuevo.Show();
        }

        private void btnLimpiar_Click(object sender, EventArgs e)
        {
            txtDescripcion.Text = "";
            cbVigencia.SelectedIndex = 0;
        }

        public void UpdateRoles()
        {
            btnBuscar.PerformClick();
        }
    }
}
