# TransformeRs

Some implementations of Transformers/Bert in R, mainly in Portuguese language.

At the moment, we have only one implementation:

## bert-restore-punctuation-ptbr

The [bert-restore-punctuation-ptbr_in_R](scripts/bert-restore-punctuation-ptbr_in_R.R)
is a script in R to use the transformer/BERT model from huggingface [bert-restore-punctuation-ptbr](https://huggingface.co/dominguesm/bert-restore-punctuation-ptbr) that restore punctuation and case. For example:

> henrique foi no lago pescar com o pedro mais tarde foram para a casa do pedro fritar os peixes

Using bert-restore-punctuation-ptbr is turned into:

> Henrique foi no lago pescar com o Pedro. Mais tarde, foram para a casa do Pedro fritar os peixes.

Because it is in huggingface, is also possible to test the model direct in site (look at the "Hosted inference API")

Soon a vignette on how to use it will be posted.