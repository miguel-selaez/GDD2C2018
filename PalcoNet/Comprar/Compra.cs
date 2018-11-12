using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace PalcoNet.Comprar
{
    public partial class Compra : Form
    {
        private Model.Session session;

        public Compra()
        {
            InitializeComponent();
        }

        public Compra(Model.Session session)
        {
            // TODO: Complete member initialization
            this.session = session;
        }
    }
}
