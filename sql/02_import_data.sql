COPY map_data_analysis
FROM 'data/anonymised_assessment_MAP.csv'
WITH (FORMAT csv, HEADER true);