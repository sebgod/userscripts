namespace SF.Zentrale.LaunchyPlugin.Infrastructure
{
    public static class ObjectHelper
    {
        public static bool IsAs<TCast>(this object @this, out TCast cast)
        {
            var isOfType = @this is TCast;
            cast = isOfType ? (TCast)@this : default(TCast);
            return isOfType;
        }

    }
}
