SELECT current_database();
SELECT version();

CREATE TABLE public.gbif_records (
    gbifID TEXT,
    datasetKey TEXT,
    occurrenceID TEXT,
    kingdom TEXT,
    phylum TEXT,
    class TEXT,
    "order" TEXT,
    family TEXT,
    genus TEXT,
    species TEXT,
    infraspecificEpithet TEXT,
    taxonRank TEXT,
    scientificName TEXT,
    verbatimScientificName TEXT,
    verbatimScientificNameAuthorship TEXT,
    countryCode TEXT,
    locality TEXT,
    stateProvince TEXT,
    occurrenceStatus TEXT,
    individualCount TEXT,
    publishingOrgKey TEXT,
    decimalLatitude TEXT,
    decimalLongitude TEXT,
    coordinateUncertaintyInMeters TEXT,
    coordinatePrecision TEXT,
    elevation TEXT,
    elevationAccuracy TEXT,
    depth TEXT,
    depthAccuracy TEXT,
    eventDate TEXT,
    day TEXT,
    month TEXT,
    year TEXT,
    taxonKey TEXT,
    speciesKey TEXT,
    basisOfRecord TEXT,
    institutionCode TEXT,
    collectionCode TEXT,
    catalogNumber TEXT,
    recordNumber TEXT,
    identifiedBy TEXT,
    dateIdentified TEXT,
    license TEXT,
    rightsHolder TEXT,
    recordedBy TEXT,
    typeStatus TEXT,
    establishmentMeans TEXT,
    lastInterpreted TEXT,
    mediaType TEXT,
    issue TEXT
);

COPY public.gbif_records
FROM 'E:/Profissional/Brazilian Anuran Biodivesity Dashboad/0063871-260519110011954.csv'
WITH (
    FORMAT text,
    DELIMITER E'\t',
    HEADER true,
    NULL '',
    ON_ERROR 'ignore'
);

SELECT column_name
FROM information_schema.columns
WHERE table_name = 'gbif_records';

SELECT 
  MIN(year), 
  MAX(year),
  COUNT(DISTINCT species)
FROM public.gbif_records;


-- DROP TABLE IF EXISTS gbif_clean;

-- ETL process for standardizing the stateProvince field.
-- Harmonization of abbreviations, spelling errors, language variants,
-- diacritical marks, and alternative representations of Brazilian states.

UPDATE public.gbif_records
SET stateProvince = CASE stateProvince
        WHEN 'Ac'               THEN 'Acre'
        WHEN 'Acrere'           THEN 'Acre'
        WHEN 'Al'               THEN 'Alagoas'
        WHEN 'Alagoasagoas'     THEN 'Alagoas'
        WHEN 'Am'               THEN 'Amazonas'
        WHEN 'Am '              THEN 'Amazonas'
        WHEN 'Amazonas ?'       THEN 'Amazonas'
        WHEN 'Amazonas/Para'    THEN 'Amazonas'
        WHEN 'Amazones'         THEN 'Amazonas'
        WHEN 'Ap'               THEN 'Amapá'
        WHEN 'Amapa'            THEN 'Amapá'
        WHEN 'Amapa Terr.'      THEN 'Amapá'
        WHEN 'Ba'               THEN 'Bahia'
        WHEN 'Bahia state'      THEN 'Bahia'
        WHEN 'Bahiahia'         THEN 'Bahia'
        WHEN 'Bahiahia state'   THEN 'Bahia'
        WHEN 'Bahiahía'         THEN 'Bahia'
        WHEN 'Bahía'            THEN 'Bahia'
        WHEN 'Ce'               THEN 'Ceará'
        WHEN 'Cearáara'         THEN 'Ceará'
        WHEN 'Cearáará'         THEN 'Ceará'
        WHEN 'Ceara'            THEN 'Ceará'
        WHEN 'Df'               THEN 'Distrito Federal'
        WHEN 'Federal Dist.'    THEN 'Distrito Federal'
        WHEN 'Es'               THEN 'Espírito Santo'
        WHEN 'Espirito Santo'   THEN 'Espírito Santo'
        WHEN 'Espirito santo'   THEN 'Espírito Santo'
        WHEN 'Go'               THEN 'Goiás'
        WHEN 'Goias'            THEN 'Goiás'
        WHEN 'Grao Para'        THEN 'Pará'
        WHEN 'Ma'               THEN 'Maranhão'
        WHEN 'Maranhao'         THEN 'Maranhão'
        WHEN 'Mg'                       THEN 'Minas Gerais'
        WHEN 'State of Minas Gerais'    THEN 'Minas Gerais'
        WHEN 'Minas gerais'             THEN 'Minas Gerais'
        WHEN 'Mina Gerais'              THEN 'Minas Gerais'
        WHEN 'Minas Gerais State'       THEN 'Minas Gerais'
        WHEN 'Mt'               THEN 'Mato Grosso'
        WHEN 'Mato grosso'      THEN 'Mato Grosso'
        WHEN 'Ms'                               THEN 'Mato Grosso do Sul'
        WHEN 'Estado de Mato Grosso do Sul'     THEN 'Mato Grosso do Sul'
        WHEN 'Mato grosso do sul'               THEN 'Mato Grosso do Sul'
        WHEN 'Mato Grosso Do Sul'               THEN 'Mato Grosso do Sul'
        WHEN 'Mato Grosso State'                THEN 'Mato Grosso do Sul'
        WHEN 'Pa'               THEN 'Pará'
        WHEN 'Para'             THEN 'Pará'
        WHEN 'Pe'               THEN 'Pernambuco'
        WHEN 'Pb'               THEN 'Paraíba'
        WHEN 'Paraiba'          THEN 'Paraíba'
        WHEN 'Pr'               THEN 'Paraná'
        WHEN 'State of Parana'  THEN 'Paraná'
        WHEN 'Parana'           THEN 'Paraná'
        WHEN 'Paráná'           THEN 'Paraná'
        WHEN 'Parana State'     THEN 'Paraná'
        WHEN 'Piaui'            THEN 'Piauí'
        WHEN 'Rj'                           THEN 'Rio de Janeiro'
        WHEN 'Río de Janeiro'               THEN 'Rio de Janeiro'
        WHEN 'Guanabara'                    THEN 'Rio de Janeiro'
        WHEN 'Rio de janeiro'               THEN 'Rio de Janeiro'
        WHEN 'Rio De Janeiro'               THEN 'Rio de Janeiro'
        WHEN 'State of Rio de Janeiro'      THEN 'Rio de Janeiro'
        WHEN 'Rn'                       THEN 'Rio Grande do Norte'
        WHEN 'Rio Grande do norte'      THEN 'Rio Grande do Norte'
        WHEN 'Rio grande do norte'      THEN 'Rio Grande do Norte'
        WHEN 'Ro'               THEN 'Rondônia'
        WHEN 'Rondonia'         THEN 'Rondônia'
        WHEN 'Rr'               THEN 'Roraima'
        WHEN 'Rs'                       THEN 'Rio Grande do Sul'
        WHEN 'Río Grande do Sul'        THEN 'Rio Grande do Sul'
        WHEN 'Rio Grande Do Sul'        THEN 'Rio Grande do Sul'
        WHEN 'Rio grande do sul'        THEN 'Rio Grande do Sul'
        WHEN 'Sc'               THEN 'Santa Catarina'
        WHEN 'Santa catarina'   THEN 'Santa Catarina'
        WHEN 'Santa Catharina'  THEN 'Santa Catarina'
        WHEN 'Sp'               THEN 'São Paulo'
        WHEN 'Sao Paulo'        THEN 'São Paulo'
        WHEN 'Sao paulo'        THEN 'São Paulo'
        WHEN 'Sao Paolo'        THEN 'São Paulo'
        WHEN 'Sâo Paulo'        THEN 'São Paulo'
        WHEN 'São paulo'        THEN 'São Paulo'
        WHEN 'São Paulo State'  THEN 'São Paulo'
        WHEN 'Sao Paulo State'  THEN 'São Paulo'
        ELSE stateProvince
    END
WHERE stateProvince IN (
    'Ac','Acrere','Al','Alagoasagoas','Am','Am ','Amazonas ?','Amazonas/Para','Amazones',
    'Ap','Amapa','Amapa Terr.','Ba','Bahia state','Bahiahia','Bahiahia state','Bahiahía','Bahía',
    'Ce','Cearáara','Cearáará','Ceara','Df','Federal Dist.','Es','Espirito Santo','Espirito santo',
    'Go','Goias','Grao Para','Ma','Maranhao','Mg','State of Minas Gerais','Minas gerais',
    'Mina Gerais','Minas Gerais State','Mt','Mato grosso','Ms','Estado de Mato Grosso do Sul',
    'Mato grosso do sul','Mato Grosso Do Sul','Mato Grosso State','Pa','Para','Pe','Pb','Paraiba',
    'Pr','State of Parana','Parana','Paráná','Parana State','Piaui','Rj','Río de Janeiro',
    'Guanabara','Rio de janeiro','Rio De Janeiro','State of Rio de Janeiro','Rn',
    'Rio Grande do norte','Rio grande do norte','Ro','Rondonia','Rr','Rs','Río Grande do Sul',
    'Rio Grande Do Sul','Rio grande do sul','Sc','Santa catarina','Santa Catharina','Sp',
    'Sao Paulo','Sao paulo','Sao Paolo','Sâo Paulo','São paulo','São Paulo State','Sao Paulo State'
);

-- Post-transformation audit:
-- identification of residual values not covered by the standardization rules.

SELECT DISTINCT stateProvince, COUNT(*) AS n
FROM public.gbif_records
GROUP BY stateProvince
ORDER BY stateProvince;

-- Data quality strategy:
-- 1. Resolve straightforward inconsistencies in the source dataset;
-- 2. Preserve the original records and create a separate curated layer;
-- 3. Explicitly classify unresolved values as NULL to avoid ambiguous categories;
-- 4. Perform residual-value audits to continuously improve data quality rules.


-- Creation of the clean data layer.
-- Application of additional standardization rules using regular expressions
-- and explicit classification of ambiguous or non-attributable records as NULL.

CREATE TABLE gbif_clean AS
SELECT *,
CASE

    -- Missing, undefined, or unusable geographic information
    WHEN stateProvince ~* 'nao especificado|não especificado|not specified|indefinido|#n/d' THEN NULL

    -- Standardization of Brazilian state names
    WHEN stateProvince ~* '^(ac|acre)$' THEN 'Acre'
    WHEN stateProvince ~* '^(al|alagoas)$' THEN 'Alagoas'
    WHEN stateProvince ~* '^(am|amazonas|Amazonas state|Amazonas, munic. de Uarini|Amazonie|Amazoonas)$' THEN 'Amazonas'
    WHEN stateProvince ~* '^(ap|amapa|Amapa State|Région d''Amapá|Amapá)$' THEN 'Amapá'
    WHEN stateProvince ~* '^(ba|bahia|Bahia State|Estado de Bahía|Municipio de Ilheus, Bahia|Municipio de Ilheus, Bahia, Fazenda Boio|Municipio de Ilheus, Bahia, Fazenda Luzitania|Municipio de Ilheus, Fazenda Lusitana|Municipio de Ilheus, Fazenda S. Domingos|Municipio de Itabuna, Bahia|Municipio de Itajuípe, Bahia)$' THEN 'Bahia'
    WHEN stateProvince ~* '^(ce|ceara|Municipio Maranguape, CEARA|Municipio Pacoti, CEARA|Ceará)$' THEN 'Ceará'
    WHEN stateProvince ~* '^(df|distrito federal|Federal District)$' THEN 'Distrito Federal'
    WHEN stateProvince ~* 'esp. santo|Esp. Santo|Espiritu Santo|Espíritu Santo|Estado de Espirito Santo|State of Espirito Santo|Espírito Santo' THEN 'Espírito Santo'
    WHEN stateProvince ~* 'goias|Goiás' THEN 'Goiás'
    WHEN stateProvince ~* 'mato grosso do sul|mt/ms|ms/mt|Mato Grosso do sul|Matro Grosso do Sul|Matto Grosso' THEN 'Mato Grosso do Sul'
    WHEN stateProvince ~* 'mato grosso|Matogrosso' THEN 'Mato Grosso'
    WHEN stateProvince ~* 'maranhao|Maranhão' THEN 'Maranhão'
    WHEN stateProvince ~* 'minas gerais|Estado de Minas Gerais' THEN 'Minas Gerais'
    WHEN stateProvince ~* 'para|Pará' THEN 'Pará'
    WHEN stateProvince ~* 'Estado de Paraíba|Parahyba' THEN 'Paraíba'
    WHEN stateProvince ~* 'piaui|Pi$|Piauí' THEN 'Piauí'
    WHEN stateProvince ~* 'parana' THEN 'Paraná'
    WHEN stateProvince ~* 'Etat de Pernambouc|Pernambouc|Pernambuco' THEN 'Pernambuco'
    WHEN stateProvince ~* 'rio de janeiro|guanabara|Angra Dos Rios|Estado Rio de Janeiro|État de Guanabara|État de Rio de Janeiro|Rio de Janeiro State' THEN 'Rio de Janeiro'
    WHEN stateProvince ~* 'rio grande do sul|Estado de Rio Grande do Sul|Estado do Rio Grande do Sul|State of Rio Grande do Sul' THEN 'Rio Grande do Sul'
    WHEN stateProvince ~* 'santa catarina' THEN 'Santa Catarina'
    WHEN stateProvince ~* 'sao paulo|são paulo|Cubatão|Etat de Sao Paulo|Guaratinguetá|São Bernardo do Campo|Saõ Paulo|Sao Paulo Santos' THEN 'São Paulo'
	WHEN stateProvince ~* 'State of Santa Catarina' THEN 'Santa Catarina'
	WHEN stateProvince ~* 'Se$|Sergipe' THEN 'Sergipe'
	WHEN stateProvince ~* 'To$|Tocantins' THEN 'Tocantins'
	WHEN stateProvince ~* 'Ro$|Rondônia' THEN 'Rondônia'
	WHEN stateProvince ~* 'Roraima' THEN 'Roraima'
	WHEN stateProvince ~* 'Rio Grande do Norte' THEN 'Rio Grande do Norte'

    -- Unresolved values:
	-- multi-state references, foreign administrative regions,
	-- or records that could not be confidently assigned to a Brazilian state.
    ELSE NULL
END AS stateProvince_clean
FROM public.gbif_records;
--

-- Quality control: validation of state-level record distribution after data standardization.

SELECT
    stateProvince_clean,
    COUNT(*) AS n
FROM gbif_clean
GROUP BY stateProvince_clean
ORDER BY n DESC;

-- Review of unmatched records for continuous improvement of data quality and ETL coverage.

SELECT
    stateProvince,
    COUNT(*) AS n
FROM gbif_clean
WHERE stateProvince_clean IS NULL
GROUP BY stateProvince
ORDER BY n DESC;

-- Date-related ETL process.

SELECT
    column_name,
    data_type
FROM information_schema.columns
WHERE table_name = 'gbif_clean'
  AND column_name IN ('eventdate','year','month','day');

-- Data consistency check:
-- validate that the day, month, and year components
-- match the information stored in eventDate whenever
-- a complete date is available.

SELECT
    COUNT(*) AS inconsistentes
FROM gbif_clean
WHERE eventdate IS NOT NULL
  AND year ~ '^[0-9]+$'
  AND month ~ '^[0-9]+$'
  AND day ~ '^[0-9]+$'
  AND (
        EXTRACT(YEAR FROM eventdate::date) <> CAST(year AS INTEGER)
     OR EXTRACT(MONTH FROM eventdate::date) <> CAST(month AS INTEGER)
     OR EXTRACT(DAY FROM eventdate::date) <> CAST(day AS INTEGER)
  );

-- Exploratory assessment of eventDate values to identify date formats and data quality issues.

SELECT
    LENGTH(eventdate) AS tamanho,
    COUNT(*) AS n
FROM gbif_clean
GROUP BY LENGTH(eventdate)
ORDER BY tamanho;

-- The eventDate field contains records with different levels of temporal granularity,
-- including year-only, year-month, complete dates, timestamps, and date ranges.
-- Examples:
-- Length 4  = Year only (e.g., 1938)
-- Length 7  = Year-month (e.g., 1938-08)
-- Length 10 = Complete ISO date (e.g., 1938-08-15)
-- Length 16–21 = ISO datetime/timestamp (e.g., 2024-05-12T14:35:00Z)
-- Length 35 = Date intervals or other complex temporal expressions (e.g., 1938-08-01/1938-08-31)
-- To preserve the original information, the source field eventDate was retained.
-- A new column (eventDate_clean) was created containing the starting date of the event whenever a valid ISO date could be extracted.

SELECT COUNT(*)
FROM gbif_clean
WHERE LENGTH(eventdate) = 10;

ALTER TABLE gbif_clean
ADD COLUMN eventdate_clean DATE;

SELECT
    COUNT(*) AS preenchidos
FROM gbif_clean
WHERE eventdate_clean IS NOT NULL;

SELECT DISTINCT eventdate
FROM gbif_clean
WHERE LENGTH(eventdate) > 10
LIMIT 50;

UPDATE gbif_clean
SET eventdate_clean =
    LEFT(eventdate,10)::DATE
WHERE eventdate ~ '^\d{4}-\d{2}-\d{2}';

SELECT
    COUNT(*) AS total_registros,
    COUNT(eventdate_clean) AS datas_validas,
    ROUND(
        COUNT(eventdate_clean) * 100.0 / COUNT(*),
        2
    ) AS percentual_datas_validas
FROM gbif_clean;

-- The dataset consists of 399,333 amphibian occurrence records sourced from GBIF.
-- Following the ETL process, 326,520 records (81.8%) were successfully parsed into
-- a standardized DATE format, while preserving data lineage from the original source.
-- This enables robust and consistent temporal analyses on the cleaned dataset.


-- ============================================================
-- ETL STEP: DERIVATION OF TEMPORAL VARIABLES
-- ============================================================
-- Based on the eventdate_clean field (DATE type), derived variables
-- were created to support temporal analyses:
-- decade  : aggregation by decade (e.g., 1990, 2000, 2010)
-- century : corresponding century of the collection year
-- season  : season of the year (Southern Hemisphere)
-- These variables were created to facilitate exploratory analyses
-- in Python/Power BI/Metabase, including temporal distribution of records,
-- historical trends in collection effort, and seasonal patterns.

-- decade

ALTER TABLE gbif_clean
ADD COLUMN decade INTEGER;

UPDATE gbif_clean
SET decade = (EXTRACT(YEAR FROM eventdate_clean)::INTEGER / 10) * 10
WHERE eventdate_clean IS NOT NULL;

SELECT decade, COUNT(*) AS n
FROM gbif_clean
GROUP BY decade
ORDER BY decade;

SELECT
    decade,
    COUNT(*) AS n,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS pct
FROM gbif_clean
GROUP BY decade
ORDER BY decade;

-- Exploratory analysis of temporal distribution by decade.
-- A substantial increase in record counts is observed from the second half of the 20th century onwards,
-- with a peak between 2000–2010. This pattern is likely associated with increased digitization efforts
-- in natural history collections and the growth of open-access biodiversity databases such as GBIF.

-- Century

ALTER TABLE gbif_clean
ADD COLUMN century INTEGER;

UPDATE gbif_clean
SET century =
    ((EXTRACT(YEAR FROM eventdate_clean)::INTEGER - 1) / 100) + 1
WHERE eventdate_clean IS NOT NULL;

SELECT century, COUNT(*) AS n
FROM gbif_clean
GROUP BY century
ORDER BY century;

-- season

ALTER TABLE gbif_clean
ADD COLUMN season VARCHAR(20);

UPDATE gbif_clean
SET season =
CASE
    WHEN EXTRACT(MONTH FROM eventdate_clean) IN (12,1,2)
        THEN 'Summer'

    WHEN EXTRACT(MONTH FROM eventdate_clean) IN (3,4,5)
        THEN 'Autumn'

    WHEN EXTRACT(MONTH FROM eventdate_clean) IN (6,7,8)
        THEN 'Winter'

    WHEN EXTRACT(MONTH FROM eventdate_clean) IN (9,10,11)
        THEN 'Spring'
END
WHERE eventdate_clean IS NOT NULL;

SELECT season, COUNT(*) AS n
FROM gbif_clean
GROUP BY season
ORDER BY season;

-- The seasonal distribution of records indicates a higher number of occurrences in
-- spring and summer in the Southern Hemisphere. This pattern may be related to
-- increased amphibian activity and detectability during warmer and wetter seasons.
-- However, it may also reflect sampling bias, as field expeditions are often
-- concentrated in periods with better environmental and logistical conditions.


-- ETL: The basisOfRecord variable describes the origin of the biological data,
-- i.e., how each record was generated or obtained.

-- Overall distribution

SELECT
    basisofrecord,
    COUNT(*) AS n
FROM gbif_clean
GROUP BY basisofrecord
ORDER BY n DESC;

-- Proportion %
SELECT
    basisofrecord,
    COUNT(*) AS n,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS pct
FROM gbif_clean
GROUP BY basisofrecord
ORDER BY n DESC;

-- Temporal/structural distribution of record types

SELECT
    decade,
    basisofrecord,
    COUNT(*) AS n
FROM gbif_clean
WHERE decade IS NOT NULL
GROUP BY decade, basisofrecord
ORDER BY decade, n DESC;

-- The basisOfRecord distribution is dominated by preserved specimens,
-- consistent with the historical and collection-based origin of much of the dataset.
--
-- Human observation records, while less abundant, represent an important component
-- of contemporary biodiversity data derived from ecological surveys and citizen science.
--
-- The presence of categories such as material samples and machine observations
-- suggests a gradual transition toward more diverse and technology-enabled data acquisition methods.


-- The institutionCode variable identifies the data provider institution associated with each record.
-- It allows the assessment of institutional contribution patterns, potential collection bias,
-- and the concentration of biodiversity data across research and museum collections.

-- General exploratory analysis

SELECT
    institutioncode,
    COUNT(*) AS n
FROM gbif_clean
GROUP BY institutioncode
ORDER BY n DESC;

-- Proportion %

SELECT
    institutioncode,
    COUNT(*) AS n,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS pct
FROM gbif_clean
GROUP BY institutioncode
ORDER BY n DESC;

-- Top institutions

SELECT
    institutioncode,
    COUNT(*) AS n
FROM gbif_clean
GROUP BY institutioncode
ORDER BY n DESC
LIMIT 20;

-- Institutional concentration analysis to assess "institutional dependency"
-- within the dataset, identifying whether records are dominated by a
-- small number of contributing institutions.

SELECT
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS pct_top10
FROM (
    SELECT institutioncode
    FROM gbif_clean
    GROUP BY institutioncode
    ORDER BY COUNT(*) DESC
    LIMIT 10
) t;

-- The distribution of institutionCode indicates a strong concentration of records
-- in a limited number of institutions, suggesting an uneven contribution landscape
-- in biodiversity data production and digitization.
-- This pattern highlights the prominent role of large museums and research institutions
-- in global biodiversity data infrastructure.


-- ETL step for column reduction (feature selection / dimensionality reduction)

-- Generate a complete diagnostic profile of all columns in the dataset
-- to assess data completeness and support decisions on column retention or removal.

DO $$
DECLARE
    col RECORD;
    sql TEXT := '';
BEGIN

    -- remove table if exists
    DROP TABLE IF EXISTS column_profile;

    FOR col IN
        SELECT column_name
        FROM information_schema.columns
        WHERE table_name = 'gbif_clean'
        ORDER BY ordinal_position
    LOOP

        sql := sql ||
        format(
        'SELECT
            ''%s'' AS column_name,
            COUNT(*) AS total_rows,
            COUNT(%I) AS non_null,
            ROUND(COUNT(%I)*100.0/COUNT(*),2) AS pct_filled
        FROM gbif_clean
        UNION ALL ',
        col.column_name,
        col.column_name,
        col.column_name
        );

    END LOOP;

    sql := left(sql, length(sql) - 10);

    EXECUTE 'CREATE TABLE column_profile AS ' || sql;

END $$;

- ver resultado
SELECT *
FROM column_profile
ORDER BY pct_filled DESC;

-- Low-information columns (low completeness or limited analytical value)

SELECT *
FROM column_profile
WHERE pct_filled < 40;

-- Columns recommended for analysis (high completeness and/or strong analytical relevance)

SELECT column_name
FROM column_profile
WHERE pct_filled >= 60
ORDER BY pct_filled DESC;

/*
Column selection criteria

Columns were retained based on a combination of completeness and analytical relevance. 
Variables with very low completeness (<40%) and limited analytical value were removed from the final dataset.

The final table (gbif_analysis) retains only variables with
high completeness and direct analytical relevance for
taxonomic, spatial and temporal analyses.
*/

-- Create a curated dataset for downstream analysis and visualization
-- (e.g., Python, statistical analysis, and dashboards such as Power BI or Metabase)
--
-- This table represents the final analytical layer of the ETL pipeline,
-- containing cleaned, standardized, and derived variables ready for modeling
-- and exploratory data analysis.

DROP TABLE IF EXISTS gbif_analysis;

CREATE TABLE gbif_analysis AS
SELECT
    gbifid,
    species,
    genus,
    family,
    scientificname,
    stateprovince_clean,
    decimallatitude,
    decimallongitude,
    eventdate_clean,
    year,
    month,
    day,
    decade,
    century,
    season,
    basisofrecord,
    institutioncode
FROM gbif_clean;

