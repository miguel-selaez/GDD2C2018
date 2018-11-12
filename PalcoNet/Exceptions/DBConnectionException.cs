using System;

namespace PalcoNet.Exceptions
{
    public class DBConnectionException : Exception
    {
        public DBConnectionException(string message) :
            
            base( "Error de Base Datos: " + message )
        { }

    }
}