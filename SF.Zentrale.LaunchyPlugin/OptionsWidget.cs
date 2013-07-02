using System.Windows.Forms;
using SF.Zentrale.LaunchyPlugin.Infrastructure;

namespace SF.Zentrale.LaunchyPlugin
{
    public partial class OptionsWidget : UserControl, IPersistentOptions
    {
        public OptionsWidget()
        {
            InitializeComponent();
        }

        public bool IsCaseSensitiveChecked
        {
            get
            {
                return caseSensitiveCheckBox.Checked;
            }
            set
            {
                caseSensitiveCheckBox.Checked = value;
            }
        }

        public string ObjectRootPath
        {
            get
            {
                return textBoxObjectRoot.Text;
            }
            set
            {
                textBoxObjectRoot.Text = value;
            }
        }
    }
}
