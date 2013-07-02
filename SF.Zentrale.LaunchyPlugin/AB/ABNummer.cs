using System;
using SF.Zentrale.LaunchyPlugin.Infrastructure;

namespace SF.Zentrale.LaunchyPlugin.AB
{
    public struct ABNummer
    {
        public const string ZentraleABProtocol = "sf-ab:";

        public enum Satztyp
        {
            Angebot,
            Auftrag,
            Reklamation
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

                    if (fuzzy.Length == 9)
                        fuzzy = "20" + fuzzy;
                    else if (fuzzy.Length == 5)
                        fuzzy = created.Value.Year + fuzzy;

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

                    if (fuzzy.Length == 8)
                        fuzzy = "20" + fuzzy;
                    else if (fuzzy.Length == 4)
                        fuzzy = created.Value.Year + fuzzy;

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
