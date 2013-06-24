using System;
using System.Windows.Forms;

namespace SF.Zentrale.LaunchyPlugin.Infrastructure
{
    public static class LoggingHelper
    {
        public static void Log(this Exception exception, string detail = "")
        {
            MessageBox.Show(String.Format("detail: {0}{1}exception: {2}{1}source:{4}{1}trace: {1}{3}", detail,
                                          Environment.NewLine,
                                          exception.Message, exception.StackTrace, exception.Source));
        }
    }
}