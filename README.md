UIML-XSLT
=========

1. Use XSLTForms 
2. Make sure XSLTForms style processing instruction is on top of your document
   - <?xml-stylesheet href="xsltforms/xsltforms.xsl" type="text/xsl"?>
3. Make sure css conversion processing instruction is set to no
   - <?css-conversion no?>
4. Remove <?xml version="1.0" encoding="UTF-8"?> if copied by mistake after XSL transformation.
5. Make sure the references to the CSS files in the 'Content' folder are correct
