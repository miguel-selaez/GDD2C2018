using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace PalcoNet.Historial_Cliente
{
    public partial class Historial : Form
    {
        private Model.Session session;

        public Historial()
        {
            InitializeComponent();
        }

        public Historial(Model.Session session)
        {
            // TODO: Complete member initialization
            this.session = session;
        }
    }
}
