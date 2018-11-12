using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace PalcoNet.Canje_Puntos
{
    public partial class Canje : Form
    {
        private Model.Session session;

        public Canje()
        {
            InitializeComponent();
        }

        public Canje(Model.Session session)
        {
            // TODO: Complete member initialization
            this.session = session;
        }
    }
}
