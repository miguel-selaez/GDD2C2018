using System;
using System.Collections.Generic;
using System.Configuration;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PalcoNet
{
    public static class Tools
    {
        private static string _systemDate;
        private static string _systemFormat;

        public static string SystemDate { get { return _systemDate ?? (_systemDate = ConfigurationManager.AppSettings["SystemDate"]); } }
        public static string SystemFormat { get { return _systemFormat ?? (_systemFormat = ConfigurationManager.AppSettings["Format"]); } }

        public static DateTime GetDate(){
            return DateTime.ParseExact(SystemDate, SystemFormat, System.Globalization.CultureInfo.InvariantCulture);
        }

        public static string ToDataBaseTime(DateTime date) {
            return date.ToString(SystemFormat);
        }

        public static DateTime ToDisplayTime(string date) {
            return DateTime.ParseExact(date, SystemFormat, CultureInfo.InvariantCulture);
        }
    }
}
