import System;

var unixEpoch : DateTime = new DateTime(1970,1,1);
var timeSinceEpoch : TimeSpan = DateTime.UtcNow - unixEpoch; // UtcNow, because timestamp is in GMT

Console.Out.WriteLine("{0:f0}", timeSinceEpoch.TotalSeconds);
