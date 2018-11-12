using PalcoNet.Exceptions;
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
    public partial class Rol : Form
    {
        private Session _session;
        private Model.Rol _editObject;
        private ListadoRol _listado;

        public Rol(Session session)
        {
            InitializeComponent();
            _session = session;
            InitValues();
        }

        private void InitValues()
        {
            var funciones = DAO.DAOFactory.FuncionDAO.GetFunciones();
            funciones = funciones.Where(f => NoExisteEnEditObject(f)).ToList();

            if (funciones.Any())
            {
                BindCbFunciones(funciones);
            }
        }

        private void BindCbFunciones(List<Model.Funcion> funciones) {
            cbFunciones.DataSource = null;
            cbFunciones.DataSource = funciones;
            cbFunciones.DisplayMember = "Descripcion";
            cbFunciones.SelectedIndex = 0;
        }

        private bool NoExisteEnEditObject(Funcion funcion)
        {
            return _editObject == null || !_editObject.Funciones.Exists(f => f.Id == funcion.Id);
        }
        public Rol(Session session, Model.Rol editRol, ListadoRol listado)
        {
            InitializeComponent();
            _session = session;
            _editObject = editRol;
            _listado = listado;
            InitValues();
            BindRol();
        }

        private void BindRol()
        {
            txtDescripcion.Text = _editObject.Descripcion;
            rdNo.Checked = _editObject.Baja;
            rdSi.Checked = !_editObject.Baja;

            BindLbFunciones(_editObject.Funciones);
        }

        private void BindLbFunciones(List<Model.Funcion> funciones) {
            lbFunciones.DataSource = null;
            lbFunciones.DataSource = funciones;
            lbFunciones.DisplayMember = "Descripcion";
        }
        private void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                ValidateForm();
                var vigente = rdNo.Checked ? true : false;
                var funciones = lbFunciones.Items.Cast<Model.Funcion>().ToList();
                if (_editObject == null)
                {
                    _editObject = new Model.Rol(txtDescripcion.Text, vigente, funciones);
                }
                else
                {
                    _editObject.Descripcion = txtDescripcion.Text;
                    _editObject.Baja = vigente;
                    _editObject.Funciones = funciones;
                }
                DAO.DAOFactory.RolDAO.CreateOrUpdate(_editObject);

                if (_listado != null)
                    _listado.UpdateRoles();

                Close();
            }
            catch(Exception ex) {
                string message = ex.Message;
                string caption = "Error de Validación";
                MessageBoxButtons buttons = MessageBoxButtons.OK;
                MessageBox.Show(message, caption, buttons);
            }
        }

        private void ValidateForm()
        {
            if (string.IsNullOrEmpty(txtDescripcion.Text)) {
                throw new ValidateException("La descripcion no puede ser nula.");
            }
            if (rdSi.Checked == false && rdNo.Checked == false) {
                throw new ValidateException("Debe seleccionar la vigencia del rol");
            }
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void btnAddFuncion_Click(object sender, EventArgs e)
        {
            var selected = (Model.Funcion) cbFunciones.SelectedValue;

            var newLbList = (List<Model.Funcion>) lbFunciones.DataSource ?? new List<Model.Funcion>();
            newLbList.Add(selected);

            BindLbFunciones(newLbList);

            var newCbList = (List<Model.Funcion>)cbFunciones.DataSource ?? new List<Model.Funcion>();
            newCbList.RemoveAt(cbFunciones.SelectedIndex);

            BindCbFunciones(newCbList);
        }

        private void btnDeleteFuncion_Click(object sender, EventArgs e)
        {
            var deletedFuncion = (Model.Funcion) lbFunciones.SelectedValue;

            var newCbList = (List<Model.Funcion>)cbFunciones.DataSource ?? new List<Model.Funcion>();
            newCbList.Add(deletedFuncion);

            BindCbFunciones(newCbList);

            var newLbList = (List<Model.Funcion>)lbFunciones.DataSource ?? new List<Model.Funcion>();
            newLbList.RemoveAt(lbFunciones.SelectedIndex);

            BindLbFunciones(newLbList);
        }

    }
}
