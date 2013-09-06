using System;
using System.Collections.Generic;
using SF.Zentrale.LaunchyPlugin.Infrastructure;

namespace SF.Zentrale.LaunchyPlugin.AB
{
    public struct ABNummer
    {
        public const string ZentraleABProtocol = "sf-ab:";
        public static readonly string ZentraleAngebotPrefix = ZentraleABProtocol + Satztyp.Angebot;
        public static readonly string ZentraleAuftragPrefix = ZentraleABProtocol + Satztyp.Auftrag;
        public static readonly string ZentraleReklaPrefix = ZentraleABProtocol + Satztyp.Reklamation;
        
        public enum Satztyp
        {
            Angebot,
            Auftrag,
            Reklamation
        }

        private static readonly Dictionary<string, Satztyp> SatztypParser = new Dictionary<string, Satztyp>(5);

        static ABNummer()
        {
            foreach (var satztyp in new[] {Satztyp.Angebot, Satztyp.Auftrag, Satztyp.Reklamation})
                SatztypParser.Add(satztyp.ToString().ToUpperInvariant(), satztyp);
        }

        public static bool TryParseSatztyp(string key, out Satztyp? satztypNullable)
        {
            Satztyp satztyp;
            return
                (satztypNullable =
                 SatztypParser.TryGetValue(key.ToUpperInvariant(), out satztyp) ? (Satztyp?) satztyp : null) != null;
        }

        private readonly DateTimeOffset _created;
        private readonly ushort _yearlyAB;
        private readonly ushort _year;
        private readonly Satztyp _satztyp;

        public ABNummer(DateTimeOffset created, ushort year, ushort yearlyAB, Satztyp satztyp)
        {
            _created = created;
            _yearlyAB = yearlyAB;
            _year = year;
            _satztyp = satztyp;
        }
        
        public DateTimeOffset CreatedOn
        {
            get { return _created; }
        }

        public ushort YearlyAB
        {
            get { return _yearlyAB; }
        }

        public ushort Year
        {
            get { return _year; }
        }

        public Satztyp Kind
        {
            get { return _satztyp; }
        }

        public static bool TryParseABNummer(out ABNummer abNummer, string fuzzy, DateTimeOffset? created = null, Satztyp? satztyp = null)
        {
            if (created == null)
                created = DateTimeOffset.Now;

            if (string.IsNullOrEmpty(fuzzy))
            {
                abNummer = default(ABNummer);
                return false;
            }

            int uriColon;
            if ((uriColon = fuzzy.IndexOf(':')) > 0)
            {
                Uri abUri;
                if (fuzzy.Substring(0, uriColon + 1).ToLowerInvariant() == ZentraleABProtocol
                    && Uri.TryCreate(fuzzy, UriKind.RelativeOrAbsolute, out abUri)
                    )
                {
                    var split = abUri.AbsolutePath.Split(new[]{'/'}, StringSplitOptions.RemoveEmptyEntries);
                    if (split.Length > 1 && TryParseSatztyp(split[0], out satztyp))
                    {
                        fuzzy = split[1];
                    }
                    else
                    {
                        fuzzy = split[0];
                    }
                }
                else
                {
                    abNummer = default(ABNummer);
                    return false;
                }
            }

            if (!satztyp.HasValue)
            {
                if (fuzzy[0] == '4')
                {
                    satztyp = Satztyp.Angebot;
                }
                else
                {
                    abNummer = default(ABNummer);
                    return false;
                }
            }

            ushort ab;
            ushort year;
            switch (satztyp)
            {
                case Satztyp.Angebot:

                    switch (fuzzy.Length)
                    {
                        case 9:
                            fuzzy = "20" + fuzzy;
                            break;
                        case 5:
                            fuzzy = created.Value.Year + fuzzy;
                            break;
                    }

                    if (fuzzy.Length == 9
                        && ushort.TryParse(fuzzy.Substring(0, 4), out year)
                        && ushort.TryParse(fuzzy.Substring(4, 4), out ab)
                        && ((int) year).IsBetweenInclusive(1985, 2100)
                        )
                    {
                        abNummer = new ABNummer(created.Value, year, ab, satztyp.Value);
                        return true;
                    }
                    goto default;

                case Satztyp.Auftrag:
                case Satztyp.Reklamation:

                    switch (fuzzy.Length)
                    {
                        case 8:
                            fuzzy = "20" + fuzzy;
                            break;
                        case 4:
                            fuzzy = created.Value.Year + fuzzy;
                            break;
                    }

                    if (fuzzy.Length == 8
                        && ushort.TryParse(fuzzy.Substring(0, 4), out year)
                        && ushort.TryParse(fuzzy.Substring(4, 4), out ab)
                        && ((int) year).IsBetweenInclusive(1985, 2100)
                        )
                    {
                        abNummer = new ABNummer(created.Value, year, ab, satztyp.Value);
                        return true;
                    }
                    goto default;

                default:
                    abNummer = default(ABNummer);
                    return false;
            }
        }
    }
}
