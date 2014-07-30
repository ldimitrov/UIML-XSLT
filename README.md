UIML-XSLT
=========

1. Use XSLTForms 
2. Use "main.xsl" as a transformation scenario - it is the main XLS file that includes references to all other xslts. 
3. Make sure XSLTForms style processing instruction is on top of your document
   - <?xml-stylesheet href="xsltforms/xsltforms.xsl" type="text/xsl"?>
4. Make sure css conversion processing instruction is set to no
   - <?css-conversion no?>
5. Remove <?xml version="1.0" encoding="UTF-8"?> if copied by mistake after XSL transformation.
6. Make sure the references to the CSS files in the 'Content' folder are correct
