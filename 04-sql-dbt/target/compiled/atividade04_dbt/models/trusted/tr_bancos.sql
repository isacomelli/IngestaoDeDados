

WITH raw_data AS (
    SELECT
        TRIM(Nome) AS nome,
        
TRIM(
    REGEXP_REPLACE(
        REGEXP_REPLACE(
            STRIP_ACCENTS(
                REPLACE(
                    REPLACE(
                        REPLACE(
                            REPLACE(
                                REPLACE(
                                    REPLACE(
                                        UPPER(TRIM(COALESCE(CAST(Nome AS VARCHAR), ''))),
                                        '- PRUDENCIAL', ''
                                    ),
                                    '(CONGLOMERADO)', ''
                                ),
                                'S.A.', ''
                            ),
                            'S/A', ''
                        ),
                        'LTDA', ''
                    ),
                    '-PRUDENCIAL', ''
                )
            ),
            '[^A-Z0-9 ]', '', 'g'
        ),
        '\\s+', ' ', 'g'
    )
)
 AS nome_norm,
        
COALESCE(
    REGEXP_REPLACE(
        REGEXP_REPLACE(
            COALESCE(CAST(CNPJ AS VARCHAR), ''),
            '[^0-9]', '', 'g'
        ),
        '^0+', ''
    ),
    ''
)
 AS cnpj_norm,
        TRIM(Segmento) AS segmento
    FROM "database"."raw"."bancos"
    WHERE Nome IS NOT NULL AND TRIM(Nome) != ''
),

ranked AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY (CASE WHEN cnpj_norm != '' AND cnpj_norm IS NOT NULL THEN cnpj_norm ELSE nome_norm END)
            ORDER BY
                (CASE WHEN segmento IS NOT NULL AND segmento != '' THEN 1 ELSE 2 END),
                nome
        ) AS row_num
    FROM raw_data
)

SELECT
    nome,
    nome_norm,
    cnpj_norm,
    segmento
FROM ranked
WHERE row_num = 1