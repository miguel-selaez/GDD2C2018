using PalcoNet.Exceptions;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace PalcoNet.AbmUsuario
{
    public partial class Usuario : Form
    {
        private Model.Session _session;
        private Model.Usuario _editObject;
        private ListadoUsuario _listado;

        public Usuario(Model.Session _session)
        {
            this._session = _session;
            InitializeComponent();
            InitValues();
        }

        public Usuario(Model.Session _session, Model.Usuario selectedUsuario, ListadoUsuario listadoUsuario)
        {
            this._session = _session;
            this._editObject = selectedUsuario;
            this._listado = listadoUsuario;
            InitializeComponent();
            InitValues();
            BindUsuario();
        }

        private void InitValues()
        {
            dtFechaNacimiento.Value = Tools.GetDate();

            var tiposDocumento = DAO.DAOFactory.TipoDocumentoDAO.GetTiposDocumento("", "Si");

            if (tiposDocumento.Any())
            {
                BindCbTiposDocumento(tiposDocumento);
            }

            var roles = DAO.DAOFactory.RolDAO.GetRoles("", "Si");
            roles = roles.Where(r => NoExisteRolEnUsuario(r)).ToList();

            if (roles.Any())
            {
                BindCbRoles(roles);
            }

            var hoteles = DAO.DAOFactory.HotelDAO.GetHoteles("", "Si");
            hoteles = hoteles.Where(h => NoExisteHotelEnUsuario(h)).ToList();

            if (hoteles.Any())
            {
                BindCbHoteles(hoteles);
            }
        }

        private void BindCbTiposDocumento(List<Model.TipoDocumento> tiposDocumento)
        {
            cbTipoDocumento.DataSource = null;
            cbTipoDocumento.DataSource = tiposDocumento;
            cbTipoDocumento.DisplayMember = "Descripcion";
            cbTipoDocumento.SelectedIndex = 0;
        }

        private void BindCbHoteles(List<Model.Hotel> hoteles)
        {
            cbHoteles.DataSource = null;
            cbHoteles.DataSource = hoteles;
            cbHoteles.DisplayMember = "Nombre";
            cbHoteles.SelectedIndex = 0;
        }

        private void BindCbRoles(List<Model.Rol> roles)
        {
            cbRoles.DataSource = null;
            cbRoles.DataSource = roles;
            cbRoles.DisplayMember = "Descripcion";
            cbRoles.SelectedIndex = 0;
        }

        private bool NoExisteRolEnUsuario(Model.Rol rol)
        {
            return _editObject == null || !_editObject.Roles.Exists(r => r.Id == rol.Id);
        }

        private bool NoExisteHotelEnUsuario(Model.Hotel hotel)
        {
            return _editObject == null || !_editObject.HotelesAsignados.Exists(r => r.Id == hotel.Id);
        }

        private int IndexOfBindTipoDocumento(int id) {
            var list = (List<Model.TipoDocumento>)cbTipoDocumento.DataSource;
            return list.FindIndex(t => t.Id == id);
        }
        private void BindUsuario()
        {
            txtNombreUsuario.Text = _editObject.NombreUsuario;
            txtNombre.Text = _editObject.Persona.Nombre;
            txtApellido.Text = _editObject.Persona.Apellido;
            txtMail.Text = _editObject.Persona.Mail;
            txtCalle.Text = _editObject.Persona.Direccion.Calle;
            txtNumeroCalle.Text = _editObject.Persona.Direccion.NumeroCalle.ToString();
            txtTelefono.Text = _editObject.Persona.Telefono;
            txtNumeroDocumento.Text = _editObject.Persona.NumeroDocumento.ToString();
            cbTipoDocumento.SelectedIndex = IndexOfBindTipoDocumento(_editObject.Persona.TipoDocumento.Id);
            dtFechaNacimiento.Value = _editObject.Persona.FechaNacimiento ?? Tools.GetDate();

            rdNo.Checked = _editObject.Baja;
            rdSi.Checked = !_editObject.Baja;

            BindLbRoles(_editObject.Roles);
            BindLbHoteles(_editObject.HotelesAsignados);
        }

        private void BindLbHoteles(List<Model.Hotel> list)
        {
            lbHoteles.DataSource = null;
            lbHoteles.DataSource = list;
            lbHoteles.DisplayMember = "Nombre";
        }

        private void BindLbRoles(List<Model.Rol> list)
        {
            lbRoles.DataSource = null;
            lbRoles.DataSource = list;
            lbRoles.DisplayMember = "Descripcion";
        }

        private void btnAddRol_Click(object sender, EventArgs e)
        {
            var selected = (Model.Rol)cbRoles.SelectedValue;

            var newLbList = (List<Model.Rol>)lbRoles.DataSource ?? new List<Model.Rol>();
            newLbList.Add(selected);

            BindLbRoles(newLbList);

            var newCbList = (List<Model.Rol>)cbRoles.DataSource ?? new List<Model.Rol>();
            newCbList.RemoveAt(cbRoles.SelectedIndex);

            BindCbRoles(newCbList);
        }

        private void btnDeleteRol_Click(object sender, EventArgs e)
        {
            var deletedFuncion = (Model.Rol)lbRoles.SelectedValue;

            var newCbList = (List<Model.Rol>)cbRoles.DataSource ?? new List<Model.Rol>();
            newCbList.Add(deletedFuncion);

            BindCbRoles(newCbList);

            var newLbList = (List<Model.Rol>)lbRoles.DataSource ?? new List<Model.Rol>();
            newLbList.RemoveAt(lbRoles.SelectedIndex);

            BindLbRoles(newLbList);
        }

        private void btnAddHotel_Click(object sender, EventArgs e)
        {
            var selected = (Model.Hotel)cbHoteles.SelectedValue;

            var newLbList = (List<Model.Hotel>)lbHoteles.DataSource ?? new List<Model.Hotel>();
            newLbList.Add(selected);

            BindLbHoteles(newLbList);

            var newCbList = (List<Model.Hotel>)cbHoteles.DataSource ?? new List<Model.Hotel>();
            newCbList.RemoveAt(cbHoteles.SelectedIndex);

            BindCbHoteles(newCbList);
        }

        private void btnDeleteHotel_Click(object sender, EventArgs e)
        {
            var deletedFuncion = (Model.Hotel)lbHoteles.SelectedValue;

            var newCbList = (List<Model.Hotel>)cbHoteles.DataSource ?? new List<Model.Hotel>();
            newCbList.Add(deletedFuncion);

            BindCbHoteles(newCbList);

            var newLbList = (List<Model.Hotel>)lbHoteles.DataSource ?? new List<Model.Hotel>();
            newLbList.RemoveAt(lbHoteles.SelectedIndex);

            BindLbHoteles(newLbList);
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                ValidateForm();
                var vigente = rdNo.Checked ? true : false;
                var roles = lbRoles.Items.Cast<Model.Rol>().ToList();
                var hoteles = lbHoteles.Items.Cast<Model.Hotel>().ToList();

                if (_editObject == null || _editObject.Id == 0)
                {
                    var direccion = new Model.Direccion(
                        txtCalle.Text,
                        Decimal.Parse(txtNumeroCalle.Text),
                        0,
                        "",
                        "",
                        null);
                    var datosPersona = new Model.Persona(
                        txtNombre.Text,
                        txtApellido.Text,
                        dtFechaNacimiento.Value,
                        txtTelefono.Text,
                        (Model.TipoDocumento) cbTipoDocumento.SelectedValue,
                        Decimal.Parse(txtNumeroDocumento.Text),
                        direccion,
                        txtMail.Text,
                        null,
                        false);
                    _editObject = new Model.Usuario(
                        txtNombreUsuario.Text, 
                        txtPassword.Text, 
                        vigente, 
                        datosPersona, 
                        roles, 
                        hoteles);
                }
                else
                {
                    _editObject.NombreUsuario = txtNombreUsuario.Text;
                    _editObject.Password = txtPassword.Text;
                    _editObject.Baja = vigente;
                    _editObject.Persona.Nombre = txtNombre.Text;
                    _editObject.Persona.Apellido = txtApellido.Text;
                    _editObject.Persona.Mail = txtMail.Text;
                    _editObject.Persona.Telefono = txtTelefono.Text;
                    _editObject.Persona.TipoDocumento = (Model.TipoDocumento) cbTipoDocumento.SelectedValue;
                    _editObject.Persona.NumeroDocumento = Decimal.Parse(txtNumeroDocumento.Text);
                    _editObject.Persona.FechaNacimiento = dtFechaNacimiento.Value;
                    _editObject.Persona.Direccion.Calle = txtCalle.Text;
                    _editObject.Persona.Direccion.NumeroCalle = Decimal.Parse(txtNumeroCalle.Text);

                    _editObject.Roles = roles;
                    _editObject.HotelesAsignados = hoteles;
                }
                DAO.DAOFactory.UsuarioDAO.CreateOrUpdate(_editObject);

                if (_listado != null)
                    _listado.UpdateUsuarios();

                Close();
            }
            catch (Exception ex)
            {
                string message = ex.Message;
                string caption = "Error de Validación";
                MessageBoxButtons buttons = MessageBoxButtons.OK;
                MessageBox.Show(message, caption, buttons);
            }
        }

        private void ValidateForm()
        {
            if (string.IsNullOrEmpty(txtNombreUsuario.Text))
            {
                throw new ValidateException("La descripcion no puede ser nula.");
            }
            if (_editObject == null && string.IsNullOrEmpty(txtPassword.Text)) {
                throw new ValidateException("El password no no puede ser nulo para un usuario nuevo.");
            }
            if (rdSi.Checked == false && rdNo.Checked == false)
            {
                throw new ValidateException("Debe seleccionar la vigencia del usuario");
            }
            if (string.IsNullOrEmpty(txtNombre.Text) || string.IsNullOrWhiteSpace(txtNombre.Text))
            {
                throw new ValidateException("El nombre no puede estar vacío.");
            }
            if (string.IsNullOrEmpty(txtApellido.Text) || string.IsNullOrWhiteSpace(txtApellido.Text))
            {
                throw new ValidateException("El apellido no puede estar vacío.");
            }
            if (string.IsNullOrEmpty(txtNumeroDocumento.Text) || string.IsNullOrWhiteSpace(txtNumeroDocumento.Text))
            {
                throw new ValidateException("El Nro de Documento no puede estar vacío.");
            }
            if (!Regex.IsMatch(txtNumeroDocumento.Text, @"[0-9]+"))
            {
                throw new ValidateException("El Nro de Documento debe estar compuesto por números únicamente.");
            }
            if (string.IsNullOrEmpty(txtMail.Text) || string.IsNullOrWhiteSpace(txtMail.Text))
            {
                throw new ValidateException("El mail no puede estar vacío.");
            }
            if (string.IsNullOrEmpty(txtTelefono.Text) || string.IsNullOrWhiteSpace(txtTelefono.Text))
            {
                throw new ValidateException("El teléfono no puede estar vacío.");
            }
            if (string.IsNullOrEmpty(txtCalle.Text) || string.IsNullOrWhiteSpace(txtCalle.Text))
            {
                throw new ValidateException("La calle no puede estar vacía.");
            }
            if (string.IsNullOrEmpty(txtNumeroCalle.Text) || string.IsNullOrWhiteSpace(txtNumeroCalle.Text))
            {
                throw new ValidateException("La altura no puede estar vacía.");
            }
            if (DateTime.Compare(dtFechaNacimiento.Value, Tools.GetDate()) > 0)
            {
                throw new ValidateException("La fecha de nacimiento no puede ser mayor a la actual");
            }
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            Close();
        }
    }
}
