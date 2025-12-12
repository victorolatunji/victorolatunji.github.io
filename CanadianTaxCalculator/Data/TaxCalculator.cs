/* 
------------------------------------------------------------
File: TaxCalculator.cs
Author: Victor Olatunji
Course: INFT 2100 – Web Application Development
Project: Canadian Tax Calculator (Blazor)
Date: December 2025

Description:
Backend tax computation engine for the Canadian Tax Calculator.
Provides all logic for calculating marginal federal and provincial
income tax based on predefined thresholds and tax rate structures.
Includes: 
  - Federal tax calculation
  - Provincial tax calculation for 10 provinces
  - Marginal tax bracket engine shared across all regions
------------------------------------------------------------
*/


namespace CanadianTaxCalculator.Data;

public class TaxCalculator
{
    // Public province list exposed to the UI
    public static readonly string[] ProvinceList = new[]
    {
        "Ontario","Quebec","British Columbia","Alberta","Manitoba",
        "Saskatchewan","Nova Scotia","New Brunswick",
        "Prince Edward Island","Newfoundland and Labrador"
    };

    // ------------------------------------------------------------
    // Federal tax structure (thresholds and rates)
    // ------------------------------------------------------------
    private readonly decimal[] FedThresholds = { 0m, 53355m, 106555m, 132200m, 226300m };
    private readonly decimal[] FedRates = { 0.145m, 0.205m, 0.26m, 0.29m, 0.33m };

    // ------------------------------------------------------------
    // Provincial tax definitions stored in a dictionary for
    // quick lookup by province name.
    // Each entry contains:
    //   - An array of thresholds
    //   - A matching array of marginal rates
    // ------------------------------------------------------------
    private readonly Dictionary<string, (decimal[] thresholds, decimal[] rates)> Prov = new()
    {
        { "Ontario", ( new[]{0m, 52886m, 105775m, 150000m, 220000m},
                       new[]{0.0505m,0.0915m,0.1116m,0.1216m,0.1316m}) },

        { "Quebec", ( new[]{0m, 53255m, 106495m, 129590m},
                      new[]{0.14m,0.19m,0.24m,0.2575m}) },

        { "British Columbia", ( new[]{0m,49279m,98560m,113158m,137407m,186306m,259829m},
                                new[]{0.0506m,0.077m,0.105m,0.1229m,0.147m,0.168m,0.205m}) },

        { "Alberta", ( new[]{0m,151234m,181481m,241974m,362961m},
                       new[]{0.10m,0.12m,0.13m,0.14m,0.15m}) },

        { "Manitoba", ( new[]{0m,47000m,100000m},
                        new[]{0.108m,0.1275m,0.174m}) },

        { "Saskatchewan", ( new[]{0m,53463m,152750m},
                           new[]{0.105m,0.125m,0.145m}) },

        { "Nova Scotia", ( new[]{0m,30507m,61015m,95883m,154650m},
                           new[]{0.0879m,0.1495m,0.1667m,0.175m,0.21m}) },

        { "New Brunswick", ( new[]{0m,44702m,89413m,142292m,162383m},
                             new[]{0.095m,0.148m,0.165m,0.178m,0.203m}) },

        { "Prince Edward Island", ( new[]{0m,33328m,64656m,105000m,140000m},
                                   new[]{0.095m,0.1347m,0.166m,0.1762m,0.19m}) },

        { "Newfoundland and Labrador", ( new[]{0m,44192m,88382m,157792m,220910m,282214m,564429m,1128858m},
                                        new[]{0.087m,0.145m,0.158m,0.178m,0.198m,0.208m,0.213m,0.218m}) }
    };

    // ------------------------------------------------------------
    // Public API - Computes federal tax only
    // ------------------------------------------------------------
    public decimal CalculateFederalTax(decimal income) =>
        CalculateMarginal(income, FedThresholds, FedRates);

    // ------------------------------------------------------------
    // Public API - Computes provincial tax based on selected province
    // ------------------------------------------------------------
    public decimal CalculateProvincialTax(decimal income, string prov)
    {
        var t = Prov[prov];
        return CalculateMarginal(income, t.thresholds, t.rates);
    }

    // ------------------------------------------------------------
    // Core logic for marginal tax calculation.
    // Iterates through threshold brackets, applying the correct
    // rate to each portion of income.
    // ------------------------------------------------------------
    private decimal CalculateMarginal(decimal income, decimal[] barriers, decimal[] rates)
    {
        decimal total = 0;

        for (int i = 0; i < rates.Length; i++)
        {
            decimal lower = barriers[i];
            decimal upper = i == rates.Length - 1 ? decimal.MaxValue : barriers[i + 1];

            if (income > lower)
            {
                decimal portion = Math.Min(income, upper) - lower;
                total += portion * rates[i];
            }
        }

        return Math.Round(total, 2);
    }
}
