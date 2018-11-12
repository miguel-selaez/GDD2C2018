using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PalcoNet.Exceptions
{
    public class LoginException : Exception
    {
        public LoginException(string message) :
            
            base( "Error de Login: " + message )
        { }
    }
}
