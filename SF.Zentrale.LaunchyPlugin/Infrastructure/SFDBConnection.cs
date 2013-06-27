using System.ComponentModel;

namespace SF.Zentrale.LaunchyPlugin.Infrastructure
{
    public partial class SFDBConnection : Component
    {
        public SFDBConnection()
        {
            InitializeComponent();
        }

        public SFDBConnection(IContainer container)
        {
            container.Add(this);

            InitializeComponent();
        }
    }
}
