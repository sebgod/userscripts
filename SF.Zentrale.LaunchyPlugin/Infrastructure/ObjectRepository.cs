using System;
using System.Collections.Generic;
using SF.Zentrale.LaunchyPlugin.Telephone;

namespace SF.Zentrale.LaunchyPlugin.Infrastructure
{
    public class ObjectRepository
    {
        private readonly Dictionary<Uri, IUriObject> _objects;
        
        private readonly Queue<IUriObject> _changedQueue;
        private readonly HashSet<Uri> _changedSet; 

        public ObjectRepository(int capacity = 100, int changeQueueCapacity = 10)
        {
            _objects = new Dictionary<Uri, IUriObject>(capacity);
            _changedQueue = new Queue<IUriObject>(changeQueueCapacity);
            _changedSet = new HashSet<Uri>();
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="uriObject">The UriObject which might have changed</param>
        /// <returns>true if the object was included in the change set or was previously unknown</returns>
        public bool AddToChangeSet(IUriObject uriObject)
        {
            var key = uriObject.Uri;
            IUriObject alreadyStoredUriObject;
            if (_objects.TryGetValue(key, out alreadyStoredUriObject) && alreadyStoredUriObject.LastUpdated >= uriObject.LastUpdated)
            {
                return false;
            }

            if (_changedSet.Add(key))
                _changedQueue.Enqueue(uriObject);

            _objects[key] = uriObject;
            return true;
        }

        public IEnumerable<IUriObject> DequeueChanged()
        {
            while (_changedQueue.Count > 0)
            {
                var changed = _changedQueue.Dequeue();
                yield return changed;
            }

            _changedSet.Clear();
        } 
    }
}