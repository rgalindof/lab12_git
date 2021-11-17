
library(biomaRt) # an alternative for annotation

listMarts() #default host is ensembl.org, and most current release of mammalian genomes
#listMarts(host="parasite.wormbase.org") #access to parasite worm genomes
#listMarts(host="protists.ensembl.org") #access to protozoan genomes


ferret.anno <- useMart(biomart = "ENSEMBL_MART_ENSEMBL", dataset = "mpfuro_gene_ensembl")
ferret.attributes <- listAttributes(ferret.anno)
Tx.ferret <- getBM(attributes = c('ensembl_transcript_id_version',
                                  'start_position',
                                  'end_position',
                                  'external_gene_name',
                                  'description',
                                  'entrezgene_id',
                                  'pfam'),
                   mart = ferret.anno)
Tx.ferret <- as_tibble(Tx.ferret)
Tx.ferret <- dplyr::rename(Tx.ferret, transcript_id = ensembl_transcript_id_version,
                                      start_position = start_position,
                                      end_position = end_position,
                                      gene_name = external_gene_name,
                                      gene_description = description,
                                      entrez_gene_id = entrezgene_id,
                                      pfam_domains = pfam,
                                      gene_name = external_gene_name)

Tx.ferret.5genes.1kb <- getSequence(id = c("IFIT2",
                                       "OAS2",
                                       "IRF1",
                                       "IFNAR1",
                                       "MX1"),
                                type = 'external_gene_name',
                                seqType = 'coding_gene_flank',
                                upstream = 1000,
                                mart = ferret.anno)


