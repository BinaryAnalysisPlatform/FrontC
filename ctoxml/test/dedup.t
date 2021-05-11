  $ echo 'typedef char uint8_t; typedef char uint8_t; typedef char uint8_t; void foo(uint8_t x);' | ctoxml
  <?xml version="1.0" encoding="iso-8859-1" standalone="yes"?>
  <file>
  	<type id="uint8_t" store="auto">
  		<char/>
  	</type>
  	<fundec id="foo" store="auto">
  		<type>
  			<void/>
  		</type>
  		<param name="x" store="auto">
  			<type ref="uint8_t"/>
  		</param>
  	</fundec>
  </file>
