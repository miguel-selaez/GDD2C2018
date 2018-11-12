using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace PalcoNet.Abm_Empresa_Espectaculo
{
    public partial class ListadoEmpresa : Form
    {
        private Model.Session session;

        public ListadoEmpresa()
        {
            InitializeComponent();
        }

        public ListadoEmpresa(Model.Session session)
        {
            // TODO: Complete member initialization
            this.session = session;
        }
    }
}
