using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace PalcoNet.Generar_Rendicion_Comisiones
{
    public partial class Rendiciones : Form
    {
        private Model.Session session;

        public Rendiciones()
        {
            InitializeComponent();
        }

        public Rendiciones(Model.Session session)
        {
            // TODO: Complete member initialization
            this.session = session;
        }
    }
}
