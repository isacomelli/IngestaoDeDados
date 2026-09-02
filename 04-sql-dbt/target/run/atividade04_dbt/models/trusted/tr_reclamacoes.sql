
    

    create  table
      "database"."trusted"."tr_reclamacoes__dbt_tmp"
  
    
    as (
      

WITH raw_rec AS (
    SELECT
        ano,
        trimestre,
        categoria,
        tipo,
        TRIM(instituicao_financeira) AS instituicao_financeira,
        
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
                                        UPPER(TRIM(COALESCE(CAST(instituicao_financeira AS VARCHAR), ''))),
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
            COALESCE(CAST(cnpj_if AS VARCHAR), ''),
            '[^0-9]', '', 'g'
        ),
        '^0+', ''
    ),
    ''
)
 AS cnpj_norm,
        TRY_CAST(TRIM(REPLACE(REPLACE(COALESCE(indice, ''), '.', ''), ',', '.')) AS DOUBLE) AS indice,
        TRY_CAST(REGEXP_REPLACE(COALESCE(qtd_reclamacoes_reguladas_procedentes, '0'), '[^0-9]', '', 'g') AS BIGINT) AS qtd_reclamacoes_reguladas_procedentes,
        TRY_CAST(REGEXP_REPLACE(COALESCE(qtd_reclamacoes_reguladas_outras, '0'), '[^0-9]', '', 'g') AS BIGINT) AS qtd_reclamacoes_reguladas_outras,
        TRY_CAST(REGEXP_REPLACE(COALESCE(qtd_reclamacoes_nao_reguladas, '0'), '[^0-9]', '', 'g') AS BIGINT) AS qtd_reclamacoes_nao_reguladas,
        TRY_CAST(REGEXP_REPLACE(COALESCE(qtd_total_reclamacoes, '0'), '[^0-9]', '', 'g') AS BIGINT) AS qtd_total_reclamacoes,
        TRY_CAST(REGEXP_REPLACE(COALESCE(qtd_total_clientes_ccs_scr, '0'), '[^0-9]', '', 'g') AS BIGINT) AS qtd_total_clientes_ccs_scr,
        TRY_CAST(REGEXP_REPLACE(COALESCE(qtd_clientes_ccs, '0'), '[^0-9]', '', 'g') AS BIGINT) AS qtd_clientes_ccs,
        TRY_CAST(REGEXP_REPLACE(COALESCE(qtd_clientes_scr, '0'), '[^0-9]', '', 'g') AS BIGINT) AS qtd_clientes_scr
    FROM "database"."raw"."reclamacoes"
    WHERE instituicao_financeira IS NOT NULL AND TRIM(instituicao_financeira) != ''
)

SELECT
    r.*,
    COALESCE(d.nome_canonico, r.nome_norm) AS nome_canonico
FROM raw_rec r
LEFT JOIN "database"."main"."de_para_bancos" d
    ON r.nome_norm = d.sigla_origem
    );
    
  