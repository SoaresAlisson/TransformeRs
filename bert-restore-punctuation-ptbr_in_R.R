# This is a script to use in R the transformer/BERT model from huggingface 
# https://huggingface.co/dominguesm/bert-restore-punctuation-ptbr that restore 
# punctuation and case.
#
# I'm very helpful to https://github.com/hhmacedo and https://huggingface.co/dominguesm
# that helped me to make this script
#
# Soon a vignette will be available


modeloBert <- huggingfaceR::hf_load_model("dominguesm/bert-restore-punctuation-ptbr")

reconstructBERT <- function(texto){
  
  df <- do.call(rbind.data.frame, modeloBert(texto)) |> 
    dplyr::select(entity, word) 
  
  while (nrow(filter(df, grepl("^##", word))) > 0) {
    df <- df |>
      dplyr::mutate(word2 =
                      case_when(!grepl("^##", word) & !grepl("^##", lead(word)) ~ word,
                                grepl("^##", word) & !grepl("^##", lag(word)) ~ 
                                  paste0(lag(word), substr(word, 3, length(word))),
                                grepl("^##", word) & grepl("^##", lag(word)) ~ word)) |>
      dplyr::filter(!is.na(word2)) |>
      dplyr::mutate(word = word2, word2 = NULL)
  }
  df |> 
    rbind(c( NA, NA)) |>
    # Converting cases and adding punctuation
    dplyr::mutate(converted = word,
                  converted = dplyr::if_else(
                    stringr::str_detect(entity, ".U"),
                    stringr::str_to_title(converted), converted),
                  converted = dplyr::if_else(
                    stringr::str_detect(entity, "\\W."),
                    stringr::str_replace(converted, "$",
                                         stringr::str_extract(entity, "\\W")),
                    converted)) |> 
    dplyr::filter(!lead(grepl("##", word)))  |># strip "broken" words
    dplyr::summarise(frase = paste(converted, collapse = " ")) |>
    dplyr::pull(frase)
}

# Just call it with text
reconstructBERT("henrique foi no lago pescar com o pedro mais tarde foram para a casa do pedro fritar os peixes")