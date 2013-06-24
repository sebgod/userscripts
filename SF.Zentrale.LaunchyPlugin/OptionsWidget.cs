using System.Windows.Forms;

namespace SF.Zentrale.LaunchyPlugin
{
    public partial class OptionsWidget : UserControl
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
    }
}
