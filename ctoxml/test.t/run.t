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

  $ ctoxml posix.h
  <?xml version="1.0" encoding="iso-8859-1" standalone="yes"?>
  <file>
  	<type id="size_t" store="auto">
  		<ulong/>
  	</type>
  	<type id="ssize_t" store="auto">
  		<long/>
  	</type>
  	<type id="div_t" store="auto">
  		<long/>
  	</type>
  	<type id="ldiv_t" store="auto">
  		<long/>
  	</type>
  	<type id="lldiv_t" store="auto">
  		<long/>
  	</type>
  	<type id="wchar_t" store="auto">
  		<long/>
  	</type>
  	<fundec id="main" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="argc" store="auto">
  			<long/>
  		</param>
  		<param name="argv" store="auto">
  			<ptr>
  				<ptr>
  					<const>
  						<char/>
  					</const>
  				</ptr>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="_Exit" store="auto">
  		<type>
  			<void/>
  		</type>
  		<param name="code" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="a64l" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="abort" store="auto">
  		<type>
  			<void/>
  		</type>
  	</fundec>
  	<fundec id="abs" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="x" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="atexit" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="callback" store="auto">
  			<ptr>
  				<fun>
  					<type>
  						<void/>
  					</type>
  				</fun>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="atof" store="auto">
  		<type>
  			<double/>
  		</type>
  		<param name="" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="atoi" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="atol" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="atoll" store="auto">
  		<type>
  			<llong/>
  		</type>
  		<param name="" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="bsearch" store="auto">
  		<type>
  			<ptr>
  				<void/>
  			</ptr>
  		</type>
  		<param name="key" store="auto">
  			<ptr>
  				<const>
  					<void/>
  				</const>
  			</ptr>
  		</param>
  		<param name="base" store="auto">
  			<ptr>
  				<const>
  					<void/>
  				</const>
  			</ptr>
  		</param>
  		<param name="nmemb" store="auto">
  			<type ref="size_t"/>
  		</param>
  		<param name="size" store="auto">
  			<type ref="size_t"/>
  		</param>
  		<param name="compare" store="auto">
  			<ptr>
  				<fun>
  					<type>
  						<long/>
  					</type>
  					<param name="" store="auto">
  						<ptr>
  							<const>
  								<void/>
  							</const>
  						</ptr>
  					</param>
  					<param name="" store="auto">
  						<ptr>
  							<const>
  								<void/>
  							</const>
  						</ptr>
  					</param>
  				</fun>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="calloc" store="auto">
  		<type>
  			<ptr>
  				<void/>
  			</ptr>
  		</type>
  		<param name="nmemb" store="auto">
  			<type ref="size_t"/>
  		</param>
  		<param name="size" store="auto">
  			<type ref="size_t"/>
  		</param>
  	</fundec>
  	<fundec id="div" store="auto">
  		<type>
  			<type ref="div_t"/>
  		</type>
  		<param name="numenator" store="auto">
  			<long/>
  		</param>
  		<param name="denominator" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="drand48" store="auto">
  		<type>
  			<double/>
  		</type>
  	</fundec>
  	<fundec id="erand48" store="auto">
  		<type>
  			<double/>
  		</type>
  		<param name="" store="auto">
  			<array>
  				<ushort/>
  				<size>
  					<int>3</int>
  				</size>
  			</array>
  		</param>
  	</fundec>
  	<fundec id="exit" store="auto">
  		<type>
  			<void/>
  		</type>
  		<param name="code" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="free" store="auto">
  		<type>
  			<void/>
  		</type>
  		<param name="ptr" store="auto">
  			<ptr>
  				<void/>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="getenv" store="auto">
  		<type>
  			<ptr>
  				<char/>
  			</ptr>
  		</type>
  		<param name="name" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="getsubopt" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="optionp" store="auto">
  			<restrict>
  				<ptr>
  					<char/>
  				</ptr>
  			</restrict>
  		</param>
  		<param name="tokens" store="auto">
  			<ptr>
  				<const>
  					<ptr>
  						<char/>
  					</ptr>
  				</const>
  			</ptr>
  		</param>
  		<param name="value" store="auto">
  			<restrict>
  				<ptr>
  					<char/>
  				</ptr>
  			</restrict>
  		</param>
  	</fundec>
  	<fundec id="grantpt" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="initstate" store="auto">
  		<type>
  			<ptr>
  				<char/>
  			</ptr>
  		</type>
  		<param name="" store="auto">
  			<ulong/>
  		</param>
  		<param name="" store="auto">
  			<ptr>
  				<char/>
  			</ptr>
  		</param>
  		<param name="" store="auto">
  			<type ref="size_t"/>
  		</param>
  	</fundec>
  	<fundec id="jrand48" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="" store="auto">
  			<array>
  				<ushort/>
  				<size>
  					<int>3</int>
  				</size>
  			</array>
  		</param>
  	</fundec>
  	<fundec id="l64a" store="auto">
  		<type>
  			<ptr>
  				<char/>
  			</ptr>
  		</type>
  		<param name="" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="labs" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="lcong48" store="auto">
  		<type>
  			<void/>
  		</type>
  		<param name="" store="auto">
  			<array>
  				<ushort/>
  				<size>
  					<int>7</int>
  				</size>
  			</array>
  		</param>
  	</fundec>
  	<fundec id="ldiv" store="auto">
  		<type>
  			<type ref="ldiv_t"/>
  		</type>
  		<param name="" store="auto">
  			<long/>
  		</param>
  		<param name="" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="llabs" store="auto">
  		<type>
  			<llong/>
  		</type>
  		<param name="" store="auto">
  			<llong/>
  		</param>
  	</fundec>
  	<fundec id="lldiv" store="auto">
  		<type>
  			<type ref="lldiv_t"/>
  		</type>
  		<param name="" store="auto">
  			<llong/>
  		</param>
  		<param name="" store="auto">
  			<llong/>
  		</param>
  	</fundec>
  	<fundec id="lrand48" store="auto">
  		<type>
  			<long/>
  		</type>
  	</fundec>
  	<fundec id="malloc" store="auto">
  		<type>
  			<ptr>
  				<void/>
  			</ptr>
  		</type>
  		<param name="size" store="auto">
  			<type ref="size_t"/>
  		</param>
  	</fundec>
  	<fundec id="mblen" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  		<param name="" store="auto">
  			<type ref="size_t"/>
  		</param>
  	</fundec>
  	<fundec id="mbstowcs" store="auto">
  		<type>
  			<type ref="size_t"/>
  		</type>
  		<param name="" store="auto">
  			<ptr>
  				<type ref="wchar_t"/>
  			</ptr>
  		</param>
  		<param name="" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  		<param name="" store="auto">
  			<type ref="size_t"/>
  		</param>
  	</fundec>
  	<fundec id="mbtowc" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="" store="auto">
  			<ptr>
  				<type ref="wchar_t"/>
  			</ptr>
  		</param>
  		<param name="" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  		<param name="" store="auto">
  			<type ref="size_t"/>
  		</param>
  	</fundec>
  	<fundec id="mkdtemp" store="auto">
  		<type>
  			<ptr>
  				<char/>
  			</ptr>
  		</type>
  		<param name="template" store="auto">
  			<ptr>
  				<char/>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="mkstemp" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="" store="auto">
  			<ptr>
  				<char/>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="mrand48" store="auto">
  		<type>
  			<long/>
  		</type>
  	</fundec>
  	<fundec id="nrand48" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="" store="auto">
  			<array>
  				<ushort/>
  				<size>
  					<int>3</int>
  				</size>
  			</array>
  		</param>
  	</fundec>
  	<fundec id="posix_memalign" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="memptr" store="auto">
  			<ptr>
  				<ptr>
  					<void/>
  				</ptr>
  			</ptr>
  		</param>
  		<param name="align" store="auto">
  			<type ref="size_t"/>
  		</param>
  		<param name="size" store="auto">
  			<type ref="size_t"/>
  		</param>
  	</fundec>
  	<fundec id="posix_openpt" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="ptsname" store="auto">
  		<type>
  			<ptr>
  				<char/>
  			</ptr>
  		</type>
  		<param name="fd" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="putenv" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="name" store="auto">
  			<ptr>
  				<char/>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="qsort" store="auto">
  		<type>
  			<void/>
  		</type>
  		<param name="base" store="auto">
  			<ptr>
  				<void/>
  			</ptr>
  		</param>
  		<param name="nmemb" store="auto">
  			<type ref="size_t"/>
  		</param>
  		<param name="size" store="auto">
  			<type ref="size_t"/>
  		</param>
  		<param name="compare" store="auto">
  			<ptr>
  				<fun>
  					<type>
  						<long/>
  					</type>
  					<param name="" store="auto">
  						<ptr>
  							<const>
  								<void/>
  							</const>
  						</ptr>
  					</param>
  					<param name="" store="auto">
  						<ptr>
  							<const>
  								<void/>
  							</const>
  						</ptr>
  					</param>
  				</fun>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="rand" store="auto">
  		<type>
  			<long/>
  		</type>
  	</fundec>
  	<fundec id="rand_r" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="seed" store="auto">
  			<ptr>
  				<ulong/>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="random" store="auto">
  		<type>
  			<long/>
  		</type>
  	</fundec>
  	<fundec id="realloc" store="auto">
  		<type>
  			<ptr>
  				<void/>
  			</ptr>
  		</type>
  		<param name="ptr" store="auto">
  			<ptr>
  				<void/>
  			</ptr>
  		</param>
  		<param name="size" store="auto">
  			<type ref="size_t"/>
  		</param>
  	</fundec>
  	<fundec id="realpath" store="auto">
  		<type>
  			<ptr>
  				<char/>
  			</ptr>
  		</type>
  		<param name="input" store="auto">
  			<restrict>
  				<const>
  					<char/>
  				</const>
  			</restrict>
  		</param>
  		<param name="output" store="auto">
  			<restrict>
  				<char/>
  			</restrict>
  		</param>
  	</fundec>
  	<fundec id="seed48" store="auto">
  		<type>
  			<ptr>
  				<ushort/>
  			</ptr>
  		</type>
  		<param name="" store="auto">
  			<array>
  				<ushort/>
  				<size>
  					<int>3</int>
  				</size>
  			</array>
  		</param>
  	</fundec>
  	<fundec id="setenv" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="name" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  		<param name="value" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  		<param name="replace" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="setkey" store="auto">
  		<type>
  			<void/>
  		</type>
  		<param name="" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="setstate" store="auto">
  		<type>
  			<ptr>
  				<char/>
  			</ptr>
  		</type>
  		<param name="buf" store="auto">
  			<ptr>
  				<char/>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="srand" store="auto">
  		<type>
  			<void/>
  		</type>
  		<param name="" store="auto">
  			<ulong/>
  		</param>
  	</fundec>
  	<fundec id="srand48" store="auto">
  		<type>
  			<void/>
  		</type>
  		<param name="" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="srandom" store="auto">
  		<type>
  			<void/>
  		</type>
  		<param name="" store="auto">
  			<ulong/>
  		</param>
  	</fundec>
  	<fundec id="strtod" store="auto">
  		<type>
  			<double/>
  		</type>
  		<param name="nptr" store="auto">
  			<restrict>
  				<const>
  					<char/>
  				</const>
  			</restrict>
  		</param>
  		<param name="endptr" store="auto">
  			<restrict>
  				<ptr>
  					<char/>
  				</ptr>
  			</restrict>
  		</param>
  	</fundec>
  	<fundec id="strtof" store="auto">
  		<type>
  			<float/>
  		</type>
  		<param name="nptr" store="auto">
  			<restrict>
  				<const>
  					<char/>
  				</const>
  			</restrict>
  		</param>
  		<param name="endptr" store="auto">
  			<restrict>
  				<ptr>
  					<char/>
  				</ptr>
  			</restrict>
  		</param>
  	</fundec>
  	<fundec id="strtol" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="nptr" store="auto">
  			<restrict>
  				<const>
  					<char/>
  				</const>
  			</restrict>
  		</param>
  		<param name="endptr" store="auto">
  			<restrict>
  				<ptr>
  					<char/>
  				</ptr>
  			</restrict>
  		</param>
  		<param name="base" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="strtold" store="auto">
  		<type>
  			<ldouble/>
  		</type>
  		<param name="nptr" store="auto">
  			<restrict>
  				<const>
  					<char/>
  				</const>
  			</restrict>
  		</param>
  		<param name="endptr" store="auto">
  			<restrict>
  				<ptr>
  					<char/>
  				</ptr>
  			</restrict>
  		</param>
  	</fundec>
  	<fundec id="strtoll" store="auto">
  		<type>
  			<llong/>
  		</type>
  		<param name="nptr" store="auto">
  			<restrict>
  				<const>
  					<char/>
  				</const>
  			</restrict>
  		</param>
  		<param name="endptr" store="auto">
  			<restrict>
  				<ptr>
  					<char/>
  				</ptr>
  			</restrict>
  		</param>
  		<param name="base" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="strtoul" store="auto">
  		<type>
  			<ulong/>
  		</type>
  		<param name="nptr" store="auto">
  			<restrict>
  				<const>
  					<char/>
  				</const>
  			</restrict>
  		</param>
  		<param name="endptr" store="auto">
  			<restrict>
  				<ptr>
  					<char/>
  				</ptr>
  			</restrict>
  		</param>
  		<param name="base" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="strtoull" store="auto">
  		<type>
  			<ulong/>
  		</type>
  		<param name="nptr" store="auto">
  			<restrict>
  				<const>
  					<char/>
  				</const>
  			</restrict>
  		</param>
  		<param name="endptr" store="auto">
  			<restrict>
  				<ptr>
  					<char/>
  				</ptr>
  			</restrict>
  		</param>
  		<param name="base" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="system" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="command" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="unlockpt" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="unsetenv" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="name" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="wcstombs" store="auto">
  		<type>
  			<type ref="size_t"/>
  		</type>
  		<param name="" store="auto">
  			<ptr>
  				<char/>
  			</ptr>
  		</param>
  		<param name="" store="auto">
  			<ptr>
  				<const>
  					<type ref="wchar_t"/>
  				</const>
  			</ptr>
  		</param>
  		<param name="" store="auto">
  			<type ref="size_t"/>
  		</param>
  	</fundec>
  	<fundec id="wctomb" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="" store="auto">
  			<ptr>
  				<char/>
  			</ptr>
  		</param>
  		<param name="" store="auto">
  			<type ref="wchar_t"/>
  		</param>
  	</fundec>
  	<type id="FILE" store="auto">
  		<ptr>
  			<void/>
  		</ptr>
  	</type>
  	<fundec id="printf" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="format" store="auto">
  			<restrict>
  				<const>
  					<char/>
  				</const>
  			</restrict>
  		</param>
  		<vararg/>
  	</fundec>
  	<fundec id="fprintf" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="stream" store="auto">
  			<restrict>
  				<type ref="FILE"/>
  			</restrict>
  		</param>
  		<param name="format" store="auto">
  			<restrict>
  				<const>
  					<char/>
  				</const>
  			</restrict>
  		</param>
  		<vararg/>
  	</fundec>
  	<fundec id="sprintf" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="str" store="auto">
  			<restrict>
  				<char/>
  			</restrict>
  		</param>
  		<param name="format" store="auto">
  			<restrict>
  				<const>
  					<char/>
  				</const>
  			</restrict>
  		</param>
  		<vararg/>
  	</fundec>
  	<fundec id="snprintf" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="str" store="auto">
  			<restrict>
  				<char/>
  			</restrict>
  		</param>
  		<param name="size" store="auto">
  			<type ref="size_t"/>
  		</param>
  		<param name="format" store="auto">
  			<restrict>
  				<const>
  					<char/>
  				</const>
  			</restrict>
  		</param>
  		<vararg/>
  	</fundec>
  	<fundec id="scanf" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="format" store="auto">
  			<restrict>
  				<const>
  					<char/>
  				</const>
  			</restrict>
  		</param>
  		<vararg/>
  	</fundec>
  	<fundec id="fscanf" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="stream" store="auto">
  			<restrict>
  				<type ref="FILE"/>
  			</restrict>
  		</param>
  		<param name="format" store="auto">
  			<restrict>
  				<const>
  					<char/>
  				</const>
  			</restrict>
  		</param>
  		<vararg/>
  	</fundec>
  	<fundec id="sscanf" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="str" store="auto">
  			<restrict>
  				<const>
  					<char/>
  				</const>
  			</restrict>
  		</param>
  		<param name="format" store="auto">
  			<restrict>
  				<const>
  					<char/>
  				</const>
  			</restrict>
  		</param>
  		<vararg/>
  	</fundec>
  	<fundec id="fgets" store="auto">
  		<type>
  			<ptr>
  				<char/>
  			</ptr>
  		</type>
  		<param name="s" store="auto">
  			<restrict>
  				<char/>
  			</restrict>
  		</param>
  		<param name="size" store="auto">
  			<long/>
  		</param>
  		<param name="stream" store="auto">
  			<restrict>
  				<type ref="FILE"/>
  			</restrict>
  		</param>
  	</fundec>
  	<fundec id="gets" store="auto">
  		<type>
  			<ptr>
  				<char/>
  			</ptr>
  		</type>
  		<param name="s" store="auto">
  			<restrict>
  				<char/>
  			</restrict>
  		</param>
  	</fundec>
  	<fundec id="fdopen" store="auto">
  		<type>
  			<ptr>
  				<type ref="FILE"/>
  			</ptr>
  		</type>
  		<param name="fd" store="auto">
  			<long/>
  		</param>
  		<param name="mode" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="fopen" store="auto">
  		<type>
  			<ptr>
  				<type ref="FILE"/>
  			</ptr>
  		</type>
  		<param name="path" store="auto">
  			<restrict>
  				<const>
  					<char/>
  				</const>
  			</restrict>
  		</param>
  		<param name="mode" store="auto">
  			<restrict>
  				<const>
  					<char/>
  				</const>
  			</restrict>
  		</param>
  	</fundec>
  	<fundec id="freopen" store="auto">
  		<type>
  			<ptr>
  				<type ref="FILE"/>
  			</ptr>
  		</type>
  		<param name="path" store="auto">
  			<restrict>
  				<const>
  					<char/>
  				</const>
  			</restrict>
  		</param>
  		<param name="mode" store="auto">
  			<restrict>
  				<const>
  					<char/>
  				</const>
  			</restrict>
  		</param>
  		<param name="stream" store="auto">
  			<restrict>
  				<type ref="FILE"/>
  			</restrict>
  		</param>
  	</fundec>
  	<fundec id="fclose" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="fp" store="auto">
  			<ptr>
  				<type ref="FILE"/>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="feof" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="stream" store="auto">
  			<ptr>
  				<type ref="FILE"/>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="ferror" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="stream" store="auto">
  			<ptr>
  				<type ref="FILE"/>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="fgetc" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="stream" store="auto">
  			<ptr>
  				<type ref="FILE"/>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="fileno" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="stream" store="auto">
  			<ptr>
  				<type ref="FILE"/>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="fputc" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="c" store="auto">
  			<long/>
  		</param>
  		<param name="stream" store="auto">
  			<ptr>
  				<type ref="FILE"/>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="fputs" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="s" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  		<param name="stream" store="auto">
  			<ptr>
  				<type ref="FILE"/>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="getc" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="stream" store="auto">
  			<ptr>
  				<type ref="FILE"/>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="getchar" store="auto">
  		<type>
  			<long/>
  		</type>
  	</fundec>
  	<fundec id="putchar" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="c" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="putc" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="c" store="auto">
  			<long/>
  		</param>
  		<param name="stream" store="auto">
  			<ptr>
  				<type ref="FILE"/>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="puts" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="s" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="remove" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="rename" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  		<param name="" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="ungetc" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="c" store="auto">
  			<long/>
  		</param>
  		<param name="stream" store="auto">
  			<ptr>
  				<type ref="FILE"/>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="fread" store="auto">
  		<type>
  			<type ref="size_t"/>
  		</type>
  		<param name="ptr" store="auto">
  			<restrict>
  				<void/>
  			</restrict>
  		</param>
  		<param name="size" store="auto">
  			<type ref="size_t"/>
  		</param>
  		<param name="nmemb" store="auto">
  			<type ref="size_t"/>
  		</param>
  		<param name="stream" store="auto">
  			<restrict>
  				<type ref="FILE"/>
  			</restrict>
  		</param>
  	</fundec>
  	<fundec id="fwrite" store="auto">
  		<type>
  			<type ref="size_t"/>
  		</type>
  		<param name="ptr" store="auto">
  			<restrict>
  				<const>
  					<void/>
  				</const>
  			</restrict>
  		</param>
  		<param name="size" store="auto">
  			<type ref="size_t"/>
  		</param>
  		<param name="nmemb" store="auto">
  			<type ref="size_t"/>
  		</param>
  		<param name="stream" store="auto">
  			<restrict>
  				<type ref="FILE"/>
  			</restrict>
  		</param>
  	</fundec>
  	<fundec id="clearerr" store="auto">
  		<type>
  			<void/>
  		</type>
  		<param name="stream" store="auto">
  			<ptr>
  				<type ref="FILE"/>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="fflush" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="stream" store="auto">
  			<ptr>
  				<type ref="FILE"/>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="__isoc99_fscanf" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="__stream" store="auto">
  			<restrict>
  				<type ref="FILE"/>
  			</restrict>
  		</param>
  		<param name="__format" store="auto">
  			<restrict>
  				<const>
  					<char/>
  				</const>
  			</restrict>
  		</param>
  		<vararg/>
  	</fundec>
  	<fundec id="__isoc99_scanf" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="__format" store="auto">
  			<restrict>
  				<const>
  					<char/>
  				</const>
  			</restrict>
  		</param>
  		<vararg/>
  	</fundec>
  	<fundec id="__isoc99_sscanf" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="__s" store="auto">
  			<restrict>
  				<const>
  					<char/>
  				</const>
  			</restrict>
  		</param>
  		<param name="__format" store="auto">
  			<restrict>
  				<const>
  					<char/>
  				</const>
  			</restrict>
  		</param>
  		<vararg/>
  	</fundec>
  	<fundec id="_IO_feof" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="stream" store="auto">
  			<ptr>
  				<type ref="FILE"/>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="_IO_getc" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="stream" store="auto">
  			<ptr>
  				<type ref="FILE"/>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="_IO_putc" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="c" store="auto">
  			<long/>
  		</param>
  		<param name="stream" store="auto">
  			<ptr>
  				<type ref="FILE"/>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="_IO_puts" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="s" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="memccpy" store="auto">
  		<type>
  			<ptr>
  				<void/>
  			</ptr>
  		</type>
  		<param name="dst" store="auto">
  			<restrict>
  				<void/>
  			</restrict>
  		</param>
  		<param name="src" store="auto">
  			<restrict>
  				<const>
  					<void/>
  				</const>
  			</restrict>
  		</param>
  		<param name="stop" store="auto">
  			<long/>
  		</param>
  		<param name="max" store="auto">
  			<type ref="size_t"/>
  		</param>
  	</fundec>
  	<fundec id="memchr" store="auto">
  		<type>
  			<ptr>
  				<void/>
  			</ptr>
  		</type>
  		<param name="s" store="auto">
  			<ptr>
  				<const>
  					<void/>
  				</const>
  			</ptr>
  		</param>
  		<param name="c" store="auto">
  			<long/>
  		</param>
  		<param name="n" store="auto">
  			<type ref="size_t"/>
  		</param>
  	</fundec>
  	<fundec id="memrchr" store="auto">
  		<type>
  			<ptr>
  				<void/>
  			</ptr>
  		</type>
  		<param name="s" store="auto">
  			<ptr>
  				<const>
  					<void/>
  				</const>
  			</ptr>
  		</param>
  		<param name="c" store="auto">
  			<long/>
  		</param>
  		<param name="n" store="auto">
  			<type ref="size_t"/>
  		</param>
  	</fundec>
  	<fundec id="memcmp" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="s1" store="auto">
  			<ptr>
  				<const>
  					<void/>
  				</const>
  			</ptr>
  		</param>
  		<param name="s2" store="auto">
  			<ptr>
  				<const>
  					<void/>
  				</const>
  			</ptr>
  		</param>
  		<param name="n" store="auto">
  			<type ref="size_t"/>
  		</param>
  	</fundec>
  	<fundec id="memcpy" store="auto">
  		<type>
  			<ptr>
  				<void/>
  			</ptr>
  		</type>
  		<param name="dst" store="auto">
  			<restrict>
  				<void/>
  			</restrict>
  		</param>
  		<param name="src" store="auto">
  			<restrict>
  				<const>
  					<void/>
  				</const>
  			</restrict>
  		</param>
  		<param name="n" store="auto">
  			<type ref="size_t"/>
  		</param>
  	</fundec>
  	<fundec id="memmove" store="auto">
  		<type>
  			<ptr>
  				<void/>
  			</ptr>
  		</type>
  		<param name="dst" store="auto">
  			<ptr>
  				<void/>
  			</ptr>
  		</param>
  		<param name="src" store="auto">
  			<ptr>
  				<const>
  					<void/>
  				</const>
  			</ptr>
  		</param>
  		<param name="n" store="auto">
  			<type ref="size_t"/>
  		</param>
  	</fundec>
  	<fundec id="memset" store="auto">
  		<type>
  			<ptr>
  				<void/>
  			</ptr>
  		</type>
  		<param name="buf" store="auto">
  			<ptr>
  				<void/>
  			</ptr>
  		</param>
  		<param name="c" store="auto">
  			<long/>
  		</param>
  		<param name="n" store="auto">
  			<type ref="size_t"/>
  		</param>
  	</fundec>
  	<fundec id="strcasecmp" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="s1" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  		<param name="s2" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="strncasecmp" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="s1" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  		<param name="s2" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  		<param name="n" store="auto">
  			<type ref="size_t"/>
  		</param>
  	</fundec>
  	<fundec id="index" store="auto">
  		<type>
  			<ptr>
  				<char/>
  			</ptr>
  		</type>
  		<param name="s" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  		<param name="c" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="rindex" store="auto">
  		<type>
  			<ptr>
  				<char/>
  			</ptr>
  		</type>
  		<param name="s" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  		<param name="c" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="stpcpy" store="auto">
  		<type>
  			<ptr>
  				<char/>
  			</ptr>
  		</type>
  		<param name="dst" store="auto">
  			<restrict>
  				<char/>
  			</restrict>
  		</param>
  		<param name="src" store="auto">
  			<restrict>
  				<const>
  					<char/>
  				</const>
  			</restrict>
  		</param>
  	</fundec>
  	<fundec id="strcat" store="auto">
  		<type>
  			<ptr>
  				<char/>
  			</ptr>
  		</type>
  		<param name="dst" store="auto">
  			<restrict>
  				<char/>
  			</restrict>
  		</param>
  		<param name="src" store="auto">
  			<restrict>
  				<const>
  					<char/>
  				</const>
  			</restrict>
  		</param>
  	</fundec>
  	<fundec id="strchr" store="auto">
  		<type>
  			<ptr>
  				<char/>
  			</ptr>
  		</type>
  		<param name="s" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  		<param name="c" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="strcmp" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="s1" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  		<param name="s2" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="strcoll" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="s1" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  		<param name="s2" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="strcpy" store="auto">
  		<type>
  			<ptr>
  				<char/>
  			</ptr>
  		</type>
  		<param name="dst" store="auto">
  			<restrict>
  				<char/>
  			</restrict>
  		</param>
  		<param name="src" store="auto">
  			<restrict>
  				<const>
  					<char/>
  				</const>
  			</restrict>
  		</param>
  	</fundec>
  	<fundec id="strcspn" store="auto">
  		<type>
  			<type ref="size_t"/>
  		</type>
  		<param name="s" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  		<param name="reject" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="strdup" store="auto">
  		<type>
  			<ptr>
  				<char/>
  			</ptr>
  		</type>
  		<param name="s" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="strfry" store="auto">
  		<type>
  			<ptr>
  				<char/>
  			</ptr>
  		</type>
  		<param name="string" store="auto">
  			<ptr>
  				<char/>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="strlen" store="auto">
  		<type>
  			<type ref="size_t"/>
  		</type>
  		<param name="s" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="strncat" store="auto">
  		<type>
  			<ptr>
  				<char/>
  			</ptr>
  		</type>
  		<param name="dst" store="auto">
  			<restrict>
  				<char/>
  			</restrict>
  		</param>
  		<param name="src" store="auto">
  			<restrict>
  				<const>
  					<char/>
  				</const>
  			</restrict>
  		</param>
  		<param name="n" store="auto">
  			<type ref="size_t"/>
  		</param>
  	</fundec>
  	<fundec id="strncmp" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="s1" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  		<param name="s2" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  		<param name="n" store="auto">
  			<type ref="size_t"/>
  		</param>
  	</fundec>
  	<fundec id="strncpy" store="auto">
  		<type>
  			<ptr>
  				<char/>
  			</ptr>
  		</type>
  		<param name="dst" store="auto">
  			<restrict>
  				<char/>
  			</restrict>
  		</param>
  		<param name="src" store="auto">
  			<restrict>
  				<const>
  					<char/>
  				</const>
  			</restrict>
  		</param>
  		<param name="n" store="auto">
  			<type ref="size_t"/>
  		</param>
  	</fundec>
  	<fundec id="strpbrk" store="auto">
  		<type>
  			<ptr>
  				<char/>
  			</ptr>
  		</type>
  		<param name="s" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  		<param name="accept" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="strrchr" store="auto">
  		<type>
  			<ptr>
  				<char/>
  			</ptr>
  		</type>
  		<param name="s" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  		<param name="c" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="strsep" store="auto">
  		<type>
  			<ptr>
  				<char/>
  			</ptr>
  		</type>
  		<param name="stringp" store="auto">
  			<ptr>
  				<ptr>
  					<char/>
  				</ptr>
  			</ptr>
  		</param>
  		<param name="delim" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="strspn" store="auto">
  		<type>
  			<type ref="size_t"/>
  		</type>
  		<param name="s" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  		<param name="accept" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="strstr" store="auto">
  		<type>
  			<ptr>
  				<char/>
  			</ptr>
  		</type>
  		<param name="haystack" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  		<param name="needle" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="strtok" store="auto">
  		<type>
  			<ptr>
  				<char/>
  			</ptr>
  		</type>
  		<param name="s" store="auto">
  			<ptr>
  				<char/>
  			</ptr>
  		</param>
  		<param name="delim" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="strxfrm" store="auto">
  		<type>
  			<type ref="size_t"/>
  		</type>
  		<param name="dst" store="auto">
  			<restrict>
  				<char/>
  			</restrict>
  		</param>
  		<param name="src" store="auto">
  			<restrict>
  				<const>
  					<char/>
  				</const>
  			</restrict>
  		</param>
  		<param name="n" store="auto">
  			<type ref="size_t"/>
  		</param>
  	</fundec>
  	<type id="mode_t" store="auto">
  		<long/>
  	</type>
  	<fundec id="open" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="pathname" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  		<param name="flags" store="auto">
  			<long/>
  		</param>
  		<vararg/>
  	</fundec>
  	<fundec id="creat" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="pathname" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  		<param name="mode" store="auto">
  			<type ref="mode_t"/>
  		</param>
  	</fundec>
  	<struct ref="struct:sockaddr"/>
  	<type id="socklen_t" store="auto">
  		<type ref="size_t"/>
  	</type>
  	<fundec id="accept" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="fd" store="auto">
  			<long/>
  		</param>
  		<param name="addr" store="auto">
  			<ptr>
  				<struct ref="struct:sockaddr"/>
  			</ptr>
  		</param>
  		<param name="len_ptr" store="auto">
  			<ptr>
  				<type ref="socklen_t"/>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="bind" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="fd" store="auto">
  			<long/>
  		</param>
  		<param name="addr" store="auto">
  			<ptr>
  				<const>
  					<struct ref="struct:sockaddr"/>
  				</const>
  			</ptr>
  		</param>
  		<param name="len" store="auto">
  			<type ref="socklen_t"/>
  		</param>
  	</fundec>
  	<fundec id="connect" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="fd" store="auto">
  			<long/>
  		</param>
  		<param name="addr" store="auto">
  			<ptr>
  				<const>
  					<struct ref="struct:sockaddr"/>
  				</const>
  			</ptr>
  		</param>
  		<param name="len" store="auto">
  			<type ref="socklen_t"/>
  		</param>
  	</fundec>
  	<fundec id="getpeername" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="fd" store="auto">
  			<long/>
  		</param>
  		<param name="addr" store="auto">
  			<ptr>
  				<struct ref="struct:sockaddr"/>
  			</ptr>
  		</param>
  		<param name="len_ptr" store="auto">
  			<ptr>
  				<type ref="socklen_t"/>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="getsockname" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="fd" store="auto">
  			<long/>
  		</param>
  		<param name="addr" store="auto">
  			<ptr>
  				<struct ref="struct:sockaddr"/>
  			</ptr>
  		</param>
  		<param name="len_ptr" store="auto">
  			<ptr>
  				<type ref="socklen_t"/>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="getsockopt" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="fd" store="auto">
  			<long/>
  		</param>
  		<param name="level" store="auto">
  			<long/>
  		</param>
  		<param name="optname" store="auto">
  			<long/>
  		</param>
  		<param name="optval" store="auto">
  			<ptr>
  				<void/>
  			</ptr>
  		</param>
  		<param name="len" store="auto">
  			<ptr>
  				<type ref="socklen_t"/>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="listen" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="fd" store="auto">
  			<long/>
  		</param>
  		<param name="n" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="recv" store="auto">
  		<type>
  			<type ref="ssize_t"/>
  		</type>
  		<param name="fd" store="auto">
  			<long/>
  		</param>
  		<param name="buf" store="auto">
  			<ptr>
  				<void/>
  			</ptr>
  		</param>
  		<param name="n" store="auto">
  			<type ref="size_t"/>
  		</param>
  		<param name="flags" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="recvfrom" store="auto">
  		<type>
  			<type ref="ssize_t"/>
  		</type>
  		<param name="fd" store="auto">
  			<long/>
  		</param>
  		<param name="buf" store="auto">
  			<restrict>
  				<void/>
  			</restrict>
  		</param>
  		<param name="n" store="auto">
  			<type ref="size_t"/>
  		</param>
  		<param name="flags" store="auto">
  			<long/>
  		</param>
  		<param name="addr" store="auto">
  			<restrict>
  				<struct ref="struct:sockaddr"/>
  			</restrict>
  		</param>
  		<param name="len_ptr" store="auto">
  			<restrict>
  				<type ref="socklen_t"/>
  			</restrict>
  		</param>
  	</fundec>
  	<fundec id="recvmsg" store="auto">
  		<type>
  			<type ref="ssize_t"/>
  		</type>
  		<param name="fd" store="auto">
  			<long/>
  		</param>
  		<param name="message" store="auto">
  			<ptr>
  				<struct ref="struct:msghdr"/>
  			</ptr>
  		</param>
  		<param name="flags" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="send" store="auto">
  		<type>
  			<type ref="ssize_t"/>
  		</type>
  		<param name="fd" store="auto">
  			<long/>
  		</param>
  		<param name="buf" store="auto">
  			<ptr>
  				<const>
  					<void/>
  				</const>
  			</ptr>
  		</param>
  		<param name="size" store="auto">
  			<type ref="size_t"/>
  		</param>
  		<param name="flags" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="sendmsg" store="auto">
  		<type>
  			<type ref="ssize_t"/>
  		</type>
  		<param name="fd" store="auto">
  			<long/>
  		</param>
  		<param name="message" store="auto">
  			<ptr>
  				<const>
  					<struct ref="struct:msghdr"/>
  				</const>
  			</ptr>
  		</param>
  		<param name="flags" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="sendto" store="auto">
  		<type>
  			<type ref="ssize_t"/>
  		</type>
  		<param name="fd" store="auto">
  			<long/>
  		</param>
  		<param name="buf" store="auto">
  			<ptr>
  				<const>
  					<void/>
  				</const>
  			</ptr>
  		</param>
  		<param name="n" store="auto">
  			<type ref="size_t"/>
  		</param>
  		<param name="flags" store="auto">
  			<long/>
  		</param>
  		<param name="addr" store="auto">
  			<ptr>
  				<const>
  					<struct ref="struct:sockaddr"/>
  				</const>
  			</ptr>
  		</param>
  		<param name="addr_len" store="auto">
  			<type ref="socklen_t"/>
  		</param>
  	</fundec>
  	<fundec id="setsockopt" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="fd" store="auto">
  			<long/>
  		</param>
  		<param name="level" store="auto">
  			<long/>
  		</param>
  		<param name="optnmae" store="auto">
  			<long/>
  		</param>
  		<param name="optval" store="auto">
  			<ptr>
  				<const>
  					<void/>
  				</const>
  			</ptr>
  		</param>
  		<param name="len" store="auto">
  			<type ref="socklen_t"/>
  		</param>
  	</fundec>
  	<fundec id="shutdown" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="fd" store="auto">
  			<long/>
  		</param>
  		<param name="command" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="sockatmark" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="fd" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="socket" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="domain" store="auto">
  			<long/>
  		</param>
  		<param name="type" store="auto">
  			<long/>
  		</param>
  		<param name="protocol" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="socketpair" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="domain" store="auto">
  			<long/>
  		</param>
  		<param name="type" store="auto">
  			<long/>
  		</param>
  		<param name="protocol" store="auto">
  			<long/>
  		</param>
  		<param name="fds" store="auto">
  			<array>
  				<long/>
  				<size>
  					<int>2</int>
  				</size>
  			</array>
  		</param>
  	</fundec>
  	<type id="uid_t" store="auto">
  		<long/>
  	</type>
  	<type id="gid_t" store="auto">
  		<long/>
  	</type>
  	<type id="pid_t" store="auto">
  		<long/>
  	</type>
  	<type id="off_t" store="auto">
  		<long/>
  	</type>
  	<fundec id="access" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="path" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  		<param name="mode" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="alarm" store="auto">
  		<type>
  			<ulong/>
  		</type>
  		<param name="seconds" store="auto">
  			<ulong/>
  		</param>
  	</fundec>
  	<fundec id="chdir" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="chown" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="parh" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  		<param name="owner" store="auto">
  			<type ref="uid_t"/>
  		</param>
  		<param name="group" store="auto">
  			<type ref="gid_t"/>
  		</param>
  	</fundec>
  	<fundec id="close" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="fd" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="confstr" store="auto">
  		<type>
  			<type ref="size_t"/>
  		</type>
  		<param name="name" store="auto">
  			<long/>
  		</param>
  		<param name="buf" store="auto">
  			<ptr>
  				<char/>
  			</ptr>
  		</param>
  		<param name="n" store="auto">
  			<type ref="size_t"/>
  		</param>
  	</fundec>
  	<fundec id="crypt" store="auto">
  		<type>
  			<ptr>
  				<char/>
  			</ptr>
  		</type>
  		<param name="key" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  		<param name="salt" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="dup" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="fd" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="dup2" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="fd" store="auto">
  			<long/>
  		</param>
  		<param name="fd2" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="_exit" store="auto">
  		<type>
  			<void/>
  		</type>
  		<param name="status" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="encrypt" store="auto">
  		<type>
  			<void/>
  		</type>
  		<param name="block" store="auto">
  			<ptr>
  				<char/>
  			</ptr>
  		</param>
  		<param name="direction" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="execl" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="path" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  		<param name="arg" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  		<vararg/>
  	</fundec>
  	<fundec id="execle" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="path" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  		<param name="arg" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  		<vararg/>
  	</fundec>
  	<fundec id="execlp" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="path" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  		<param name="arg" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  		<vararg/>
  	</fundec>
  	<fundec id="execv" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="path" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  		<param name="argv" store="auto">
  			<array>
  				<const>
  					<ptr>
  						<char/>
  					</ptr>
  				</const>
  				<size>
  					<nothing/>
  				</size>
  			</array>
  		</param>
  	</fundec>
  	<fundec id="execve" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="path" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  		<param name="argv" store="auto">
  			<array>
  				<const>
  					<ptr>
  						<char/>
  					</ptr>
  				</const>
  				<size>
  					<nothing/>
  				</size>
  			</array>
  		</param>
  		<param name="envp" store="auto">
  			<array>
  				<const>
  					<ptr>
  						<char/>
  					</ptr>
  				</const>
  				<size>
  					<nothing/>
  				</size>
  			</array>
  		</param>
  	</fundec>
  	<fundec id="execvp" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="path" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  		<param name="argv" store="auto">
  			<array>
  				<const>
  					<ptr>
  						<char/>
  					</ptr>
  				</const>
  				<size>
  					<nothing/>
  				</size>
  			</array>
  		</param>
  	</fundec>
  	<fundec id="faccessat" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="" store="auto">
  			<long/>
  		</param>
  		<param name="" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  		<param name="" store="auto">
  			<long/>
  		</param>
  		<param name="" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="fchdir" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="fd" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="fchown" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="fd" store="auto">
  			<long/>
  		</param>
  		<param name="owner" store="auto">
  			<type ref="uid_t"/>
  		</param>
  		<param name="group" store="auto">
  			<type ref="gid_t"/>
  		</param>
  	</fundec>
  	<fundec id="fchownat" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="fd" store="auto">
  			<long/>
  		</param>
  		<param name="path" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  		<param name="owner" store="auto">
  			<type ref="uid_t"/>
  		</param>
  		<param name="group" store="auto">
  			<type ref="gid_t"/>
  		</param>
  		<param name="flag" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="fdatasync" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="fd" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="fexecve" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="fd" store="auto">
  			<long/>
  		</param>
  		<param name="argv" store="auto">
  			<array>
  				<const>
  					<ptr>
  						<char/>
  					</ptr>
  				</const>
  				<size>
  					<nothing/>
  				</size>
  			</array>
  		</param>
  		<param name="envp" store="auto">
  			<array>
  				<const>
  					<ptr>
  						<char/>
  					</ptr>
  				</const>
  				<size>
  					<nothing/>
  				</size>
  			</array>
  		</param>
  	</fundec>
  	<fundec id="fork" store="auto">
  		<type>
  			<type ref="pid_t"/>
  		</type>
  	</fundec>
  	<fundec id="fpathconf" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="fd" store="auto">
  			<long/>
  		</param>
  		<param name="name" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="fsync" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="fd" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="ftruncate" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="fd" store="auto">
  			<long/>
  		</param>
  		<param name="len" store="auto">
  			<type ref="off_t"/>
  		</param>
  	</fundec>
  	<fundec id="getcwd" store="auto">
  		<type>
  			<ptr>
  				<char/>
  			</ptr>
  		</type>
  		<param name="" store="auto">
  			<ptr>
  				<char/>
  			</ptr>
  		</param>
  		<param name="" store="auto">
  			<type ref="size_t"/>
  		</param>
  	</fundec>
  	<fundec id="getegid" store="auto">
  		<type>
  			<type ref="gid_t"/>
  		</type>
  	</fundec>
  	<fundec id="geteuid" store="auto">
  		<type>
  			<type ref="uid_t"/>
  		</type>
  	</fundec>
  	<fundec id="getgid" store="auto">
  		<type>
  			<type ref="gid_t"/>
  		</type>
  	</fundec>
  	<fundec id="getgroups" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="size" store="auto">
  			<long/>
  		</param>
  		<param name="list" store="auto">
  			<array>
  				<type ref="gid_t"/>
  				<size>
  					<nothing/>
  				</size>
  			</array>
  		</param>
  	</fundec>
  	<fundec id="gethostid" store="auto">
  		<type>
  			<long/>
  		</type>
  	</fundec>
  	<fundec id="gethostname" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="buf" store="auto">
  			<ptr>
  				<char/>
  			</ptr>
  		</param>
  		<param name="len" store="auto">
  			<type ref="size_t"/>
  		</param>
  	</fundec>
  	<fundec id="getlogin" store="auto">
  		<type>
  			<ptr>
  				<char/>
  			</ptr>
  		</type>
  	</fundec>
  	<fundec id="getlogin_r" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="buf" store="auto">
  			<ptr>
  				<char/>
  			</ptr>
  		</param>
  		<param name="size" store="auto">
  			<type ref="size_t"/>
  		</param>
  	</fundec>
  	<fundec id="getopt" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="argc" store="auto">
  			<long/>
  		</param>
  		<param name="argv" store="auto">
  			<ptr>
  				<const>
  					<ptr>
  						<char/>
  					</ptr>
  				</const>
  			</ptr>
  		</param>
  		<param name="shortopts" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="getpgid" store="auto">
  		<type>
  			<type ref="pid_t"/>
  		</type>
  		<param name="pid" store="auto">
  			<type ref="pid_t"/>
  		</param>
  	</fundec>
  	<fundec id="getpgrp" store="auto">
  		<type>
  			<type ref="pid_t"/>
  		</type>
  	</fundec>
  	<fundec id="getpid" store="auto">
  		<type>
  			<type ref="pid_t"/>
  		</type>
  	</fundec>
  	<fundec id="getppid" store="auto">
  		<type>
  			<type ref="pid_t"/>
  		</type>
  	</fundec>
  	<fundec id="getsid" store="auto">
  		<type>
  			<type ref="pid_t"/>
  		</type>
  		<param name="pid" store="auto">
  			<type ref="pid_t"/>
  		</param>
  	</fundec>
  	<fundec id="getuid" store="auto">
  		<type>
  			<type ref="uid_t"/>
  		</type>
  	</fundec>
  	<fundec id="isatty" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="fd" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="lchown" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="file" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  		<param name="owner" store="auto">
  			<type ref="uid_t"/>
  		</param>
  		<param name="group" store="auto">
  			<type ref="gid_t"/>
  		</param>
  	</fundec>
  	<fundec id="link" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="from" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  		<param name="to" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="linkat" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="fromfd" store="auto">
  			<long/>
  		</param>
  		<param name="from" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  		<param name="tofd" store="auto">
  			<long/>
  		</param>
  		<param name="to" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  		<param name="flags" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="lockf" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="fd" store="auto">
  			<long/>
  		</param>
  		<param name="cmd" store="auto">
  			<long/>
  		</param>
  		<param name="len" store="auto">
  			<type ref="off_t"/>
  		</param>
  	</fundec>
  	<fundec id="lseek" store="auto">
  		<type>
  			<type ref="off_t"/>
  		</type>
  		<param name="fd" store="auto">
  			<long/>
  		</param>
  		<param name="off" store="auto">
  			<type ref="off_t"/>
  		</param>
  		<param name="whence" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="nice" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="pathconf" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="path" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  		<param name="name" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="pause" store="auto">
  		<type>
  			<long/>
  		</type>
  	</fundec>
  	<fundec id="pipe" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="" store="auto">
  			<array>
  				<long/>
  				<size>
  					<int>2</int>
  				</size>
  			</array>
  		</param>
  	</fundec>
  	<fundec id="pread" store="auto">
  		<type>
  			<type ref="ssize_t"/>
  		</type>
  		<param name="fd" store="auto">
  			<long/>
  		</param>
  		<param name="buf" store="auto">
  			<ptr>
  				<void/>
  			</ptr>
  		</param>
  		<param name="nbytes" store="auto">
  			<type ref="size_t"/>
  		</param>
  		<param name="off" store="auto">
  			<type ref="off_t"/>
  		</param>
  	</fundec>
  	<fundec id="pwrite" store="auto">
  		<type>
  			<type ref="ssize_t"/>
  		</type>
  		<param name="fd" store="auto">
  			<long/>
  		</param>
  		<param name="buf" store="auto">
  			<ptr>
  				<const>
  					<void/>
  				</const>
  			</ptr>
  		</param>
  		<param name="nbytes" store="auto">
  			<type ref="size_t"/>
  		</param>
  		<param name="off" store="auto">
  			<type ref="off_t"/>
  		</param>
  	</fundec>
  	<fundec id="read" store="auto">
  		<type>
  			<type ref="ssize_t"/>
  		</type>
  		<param name="fd" store="auto">
  			<long/>
  		</param>
  		<param name="buf" store="auto">
  			<ptr>
  				<void/>
  			</ptr>
  		</param>
  		<param name="nbytes" store="auto">
  			<type ref="size_t"/>
  		</param>
  	</fundec>
  	<fundec id="readv" store="auto">
  		<type>
  			<type ref="ssize_t"/>
  		</type>
  		<param name="fd" store="auto">
  			<long/>
  		</param>
  		<param name="iov" store="auto">
  			<ptr>
  				<const>
  					<struct ref="struct:iovec"/>
  				</const>
  			</ptr>
  		</param>
  		<param name="iovcnt" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="readlink" store="auto">
  		<type>
  			<type ref="ssize_t"/>
  		</type>
  		<param name="path" store="auto">
  			<restrict>
  				<const>
  					<char/>
  				</const>
  			</restrict>
  		</param>
  		<param name="buf" store="auto">
  			<restrict>
  				<char/>
  			</restrict>
  		</param>
  		<param name="len" store="auto">
  			<type ref="size_t"/>
  		</param>
  	</fundec>
  	<fundec id="readlinkat" store="auto">
  		<type>
  			<type ref="ssize_t"/>
  		</type>
  		<param name="fd" store="auto">
  			<long/>
  		</param>
  		<param name="path" store="auto">
  			<restrict>
  				<const>
  					<char/>
  				</const>
  			</restrict>
  		</param>
  		<param name="buf" store="auto">
  			<restrict>
  				<char/>
  			</restrict>
  		</param>
  		<param name="len" store="auto">
  			<type ref="size_t"/>
  		</param>
  	</fundec>
  	<fundec id="rmdir" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="path" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="setegid" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="" store="auto">
  			<type ref="gid_t"/>
  		</param>
  	</fundec>
  	<fundec id="seteuid" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="" store="auto">
  			<type ref="uid_t"/>
  		</param>
  	</fundec>
  	<fundec id="setgid" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="" store="auto">
  			<type ref="gid_t"/>
  		</param>
  	</fundec>
  	<fundec id="setpgid" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="pid" store="auto">
  			<type ref="pid_t"/>
  		</param>
  		<param name="pgid" store="auto">
  			<type ref="pid_t"/>
  		</param>
  	</fundec>
  	<fundec id="setpgrp" store="auto">
  		<type>
  			<type ref="pid_t"/>
  		</type>
  	</fundec>
  	<fundec id="setregid" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="" store="auto">
  			<type ref="gid_t"/>
  		</param>
  		<param name="" store="auto">
  			<type ref="gid_t"/>
  		</param>
  	</fundec>
  	<fundec id="setreuid" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="" store="auto">
  			<type ref="uid_t"/>
  		</param>
  		<param name="" store="auto">
  			<type ref="uid_t"/>
  		</param>
  	</fundec>
  	<fundec id="setsid" store="auto">
  		<type>
  			<type ref="pid_t"/>
  		</type>
  	</fundec>
  	<fundec id="setuid" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="" store="auto">
  			<type ref="uid_t"/>
  		</param>
  	</fundec>
  	<fundec id="sleep" store="auto">
  		<type>
  			<ulong/>
  		</type>
  		<param name="" store="auto">
  			<ulong/>
  		</param>
  	</fundec>
  	<fundec id="swab" store="auto">
  		<type>
  			<void/>
  		</type>
  		<param name="from" store="auto">
  			<ptr>
  				<const>
  					<void/>
  				</const>
  			</ptr>
  		</param>
  		<param name="to" store="auto">
  			<ptr>
  				<void/>
  			</ptr>
  		</param>
  		<param name="n" store="auto">
  			<type ref="ssize_t"/>
  		</param>
  	</fundec>
  	<fundec id="symlink" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="from" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  		<param name="to" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="symlinkat" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="from" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  		<param name="fromfd" store="auto">
  			<long/>
  		</param>
  		<param name="to" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="sync" store="auto">
  		<type>
  			<void/>
  		</type>
  	</fundec>
  	<fundec id="sysconf" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="tcgetpgrp" store="auto">
  		<type>
  			<type ref="pid_t"/>
  		</type>
  		<param name="" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="tcsetpgrp" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="" store="auto">
  			<long/>
  		</param>
  		<param name="" store="auto">
  			<type ref="pid_t"/>
  		</param>
  	</fundec>
  	<fundec id="truncate" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="file" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  		<param name="length" store="auto">
  			<type ref="off_t"/>
  		</param>
  	</fundec>
  	<fundec id="ttyname" store="auto">
  		<type>
  			<ptr>
  				<char/>
  			</ptr>
  		</type>
  		<param name="" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="ttyname_r" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="" store="auto">
  			<long/>
  		</param>
  		<param name="" store="auto">
  			<ptr>
  				<char/>
  			</ptr>
  		</param>
  		<param name="" store="auto">
  			<type ref="size_t"/>
  		</param>
  	</fundec>
  	<fundec id="unlink" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="name" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="unlinkat" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="fd" store="auto">
  			<long/>
  		</param>
  		<param name="name" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  		<param name="flags" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="write" store="auto">
  		<type>
  			<type ref="ssize_t"/>
  		</type>
  		<param name="" store="auto">
  			<long/>
  		</param>
  		<param name="" store="auto">
  			<ptr>
  				<const>
  					<void/>
  				</const>
  			</ptr>
  		</param>
  		<param name="" store="auto">
  			<type ref="size_t"/>
  		</param>
  	</fundec>
  	<fundec id="popen" store="auto">
  		<type>
  			<ptr>
  				<type ref="FILE"/>
  			</ptr>
  		</type>
  		<param name="cmd" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  		<param name="type" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="posix_spawn" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="pid" store="auto">
  			<ptr>
  				<type ref="pid_t"/>
  			</ptr>
  		</param>
  		<param name="path" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  		<param name="file_actions" store="auto">
  			<ptr>
  				<const>
  					<void/>
  				</const>
  			</ptr>
  		</param>
  		<param name="attrp" store="auto">
  			<ptr>
  				<const>
  					<void/>
  				</const>
  			</ptr>
  		</param>
  		<param name="argv" store="auto">
  			<array>
  				<const>
  					<ptr>
  						<char/>
  					</ptr>
  				</const>
  				<size>
  					<nothing/>
  				</size>
  			</array>
  		</param>
  		<param name="envp" store="auto">
  			<array>
  				<const>
  					<ptr>
  						<char/>
  					</ptr>
  				</const>
  				<size>
  					<nothing/>
  				</size>
  			</array>
  		</param>
  	</fundec>
  	<fundec id="posix_spawnp" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="pid" store="auto">
  			<ptr>
  				<type ref="pid_t"/>
  			</ptr>
  		</param>
  		<param name="file" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  		<param name="file_actions" store="auto">
  			<ptr>
  				<const>
  					<void/>
  				</const>
  			</ptr>
  		</param>
  		<param name="attrp" store="auto">
  			<ptr>
  				<const>
  					<void/>
  				</const>
  			</ptr>
  		</param>
  		<param name="argv" store="auto">
  			<array>
  				<const>
  					<ptr>
  						<char/>
  					</ptr>
  				</const>
  				<size>
  					<nothing/>
  				</size>
  			</array>
  		</param>
  		<param name="envp" store="auto">
  			<array>
  				<const>
  					<ptr>
  						<char/>
  					</ptr>
  				</const>
  				<size>
  					<nothing/>
  				</size>
  			</array>
  		</param>
  	</fundec>
  	<fundec id="__errno_location" store="auto">
  		<type>
  			<ptr>
  				<long/>
  			</ptr>
  		</type>
  	</fundec>
  	<fundec id="brk" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="addr" store="auto">
  			<ptr>
  				<void/>
  			</ptr>
  		</param>
  	</fundec>
  	<fundec id="sbrk" store="auto">
  		<type>
  			<ptr>
  				<void/>
  			</ptr>
  		</type>
  		<param name="increment" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="isalnum" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="c" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="isalpha" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="c" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="iscntrl" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="c" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="isdigit" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="c" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="isgraph" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="c" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="islower" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="c" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="isprint" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="c" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="ispunct" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="c" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="isspace" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="c" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="isupper" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="c" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="isxdigit" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="c" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="isascii" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="c" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="isblank" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="c" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="toupper" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="c" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="tolower" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="c" store="auto">
  			<long/>
  		</param>
  	</fundec>
  </file>

  $ echo 'struct foo {int x;};' | ctoxml
  <?xml version="1.0" encoding="iso-8859-1" standalone="yes"?>
  <file>
  	<struct id="struct:foo">
  		<field name="x">
  			<long/>
  		</field>
  	</struct>
  </file>

  $ echo 'typedef int T; T bar();' | ctoxml
  <?xml version="1.0" encoding="iso-8859-1" standalone="yes"?>
  <file>
  	<type id="T" store="auto">
  		<long/>
  	</type>
  	<fundec id="bar" store="auto">
  		<type>
  			<type ref="T"/>
  		</type>
  	</fundec>
  </file>

  $ echo 'const volatile int n;' | ctoxml
  <?xml version="1.0" encoding="iso-8859-1" standalone="yes"?>
  <file>
  	<var id="n" store="auto">
  		<volatile>
  			<const>
  				<long/>
  			</const>
  		</volatile>
  	</var>
  </file>

  $ ctoxml echo.c
  <?xml version="1.0" encoding="iso-8859-1" standalone="yes"?>
  <file>
  	<var id="strv" store="auto">
  		<array>
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  			<size>
  				<nothing/>
  			</size>
  		</array>
  		<compound>
  			<string>Now we will print some random stuff.</string>
  			<string>Be not afraid of greatness:</string>
  			<string>some are born great, some achieve greatness</string>
  			<string>and some have greatness thrust upon them</string>
  			<string>To thine own self be true, and it must follow</string>
  			<string>as the night the day, thou canst not</string>
  			<string>then be false to any man</string>
  			<string>The course of true love never did run smooth</string>
  		</compound>
  	</var>
  	<fundef id="print_endline" store="auto">
  		<type>
  			<void/>
  		</type>
  		<param name="msg" store="auto">
  			<ptr>
  				<const>
  					<char/>
  				</const>
  			</ptr>
  		</param>
  		<body>
  			<var id="p" store="auto">
  				<ptr>
  					<char/>
  				</ptr>
  				<get ref="msg"/>
  			</var>
  			<while>
  				<memof>
  					<get ref="p"/>
  				</memof>
  				<call>
  					<get ref="putchar"/>
  					<memof>
  						<postinc>
  							<get ref="p"/>
  						</postinc>
  					</memof>
  				</call>
  			</while>
  			<call>
  				<get ref="putchar"/>
  				<char>
  </char>
  			</call>
  		</body>
  	</fundef>
  	<fundef id="print_strings" store="auto">
  		<type>
  			<void/>
  		</type>
  		<param name="strings" store="auto">
  			<ptr>
  				<ptr>
  					<const>
  						<char/>
  					</const>
  				</ptr>
  			</ptr>
  		</param>
  		<body>
  			<for>
  				<set>
  					<get ref="p"/>
  					<get ref="strings"/>
  				</set>
  				<memof>
  					<get ref="p"/>
  				</memof>
  				<postinc>
  					<get ref="p"/>
  				</postinc>
  				<block>
  					<call>
  						<get ref="print_endline"/>
  						<memof>
  							<get ref="p"/>
  						</memof>
  					</call>
  				</block>
  			</for>
  		</body>
  	</fundef>
  	<fundef id="main" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="argc" store="auto">
  			<long/>
  		</param>
  		<param name="argv" store="auto">
  			<ptr>
  				<ptr>
  					<const>
  						<char/>
  					</const>
  				</ptr>
  			</ptr>
  		</param>
  		<body>
  			<var id="i" store="auto">
  				<long/>
  			</var>
  			<var id="j" store="auto">
  				<long/>
  			</var>
  			<var id="strc" store="auto">
  				<const>
  					<long/>
  				</const>
  				<div>
  					<sizeof>
  						<get ref="strv"/>
  					</sizeof>
  					<sizeof>
  						<memof>
  							<get ref="strv"/>
  						</memof>
  					</sizeof>
  				</div>
  			</var>
  			<var id="size" store="auto">
  				<const>
  					<long/>
  				</const>
  				<add>
  					<add>
  						<get ref="argc"/>
  						<get ref="strc"/>
  					</add>
  					<int>1</int>
  				</add>
  			</var>
  			<var id="strings" store="auto">
  				<array>
  					<ptr>
  						<char/>
  					</ptr>
  					<size>
  						<get ref="size"/>
  					</size>
  				</array>
  			</var>
  			<for>
  				<set>
  					<get ref="i"/>
  					<int>0</int>
  				</set>
  				<lt>
  					<get ref="i"/>
  					<get ref="argc"/>
  				</lt>
  				<postinc>
  					<get ref="i"/>
  				</postinc>
  				<block>
  					<set>
  						<index>
  							<get ref="strings"/>
  							<get ref="i"/>
  						</index>
  						<call>
  							<get ref="strcpy"/>
  							<call>
  								<get ref="malloc"/>
  								<add>
  									<call>
  										<get ref="strlen"/>
  										<index>
  											<get ref="argv"/>
  											<get ref="i"/>
  										</index>
  									</call>
  									<int>1</int>
  								</add>
  							</call>
  							<index>
  								<get ref="argv"/>
  								<get ref="i"/>
  							</index>
  						</call>
  					</set>
  				</block>
  			</for>
  			<for>
  				<set>
  					<get ref="j"/>
  					<int>0</int>
  				</set>
  				<lt>
  					<get ref="j"/>
  					<get ref="strc"/>
  				</lt>
  				<comma>
  					<postinc>
  						<get ref="j"/>
  					</postinc>
  					<postinc>
  						<get ref="i"/>
  					</postinc>
  				</comma>
  				<block>
  					<var id="b" store="auto">
  						<ptr>
  							<char/>
  						</ptr>
  						<add>
  							<call>
  								<get ref="strchr"/>
  								<index>
  									<get ref="strv"/>
  									<get ref="j"/>
  								</index>
  								<char> </char>
  							</call>
  							<int>1</int>
  						</add>
  					</var>
  					<var id="e" store="auto">
  						<ptr>
  							<char/>
  						</ptr>
  						<call>
  							<get ref="strchr"/>
  							<get ref="b"/>
  							<char> </char>
  						</call>
  					</var>
  					<var id="dst" store="auto">
  						<ptr>
  							<char/>
  						</ptr>
  						<call>
  							<get ref="malloc"/>
  							<get ref="size"/>
  						</call>
  					</var>
  					<call>
  						<get ref="memmove"/>
  						<get ref="dst"/>
  						<get ref="b"/>
  						<get ref="size"/>
  					</call>
  					<set>
  						<index>
  							<get ref="dst"/>
  							<sub>
  								<get ref="size"/>
  								<int>1</int>
  							</sub>
  						</index>
  						<get ref="NULL"/>
  					</set>
  					<set>
  						<index>
  							<get ref="strings"/>
  							<get ref="i"/>
  						</index>
  						<get ref="dst"/>
  					</set>
  				</block>
  			</for>
  			<set>
  				<index>
  					<get ref="strings"/>
  					<sub>
  						<get ref="size"/>
  						<int>1</int>
  					</sub>
  				</index>
  				<get ref="NULL"/>
  			</set>
  			<call>
  				<get ref="print_strings"/>
  				<get ref="strings"/>
  			</call>
  			<for>
  				<set>
  					<get ref="i"/>
  					<int>0</int>
  				</set>
  				<lt>
  					<get ref="i"/>
  					<get ref="size"/>
  				</lt>
  				<postinc>
  					<get ref="i"/>
  				</postinc>
  				<block>
  					<call>
  						<get ref="free"/>
  						<index>
  							<get ref="strings"/>
  							<get ref="i"/>
  						</index>
  					</call>
  				</block>
  			</for>
  			<return>
  				<int>0</int>
  			</return>
  		</body>
  	</fundef>
  </file>
  $ ctoxml so.c
  <?xml version="1.0" encoding="iso-8859-1" standalone="yes"?>
  <file>
  	<fundec id="foo" store="static">
  		<type>
  			<void/>
  		</type>
  		<param name="a" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundec id="bar" store="extern">
  		<type>
  			<void/>
  		</type>
  		<param name="a" store="auto">
  			<long/>
  		</param>
  	</fundec>
  </file>
  $ ctoxml obj.c
  <?xml version="1.0" encoding="iso-8859-1" standalone="yes"?>
  <file>
  	<fundef id="sum_internal_1" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="a" store="auto">
  			<long/>
  		</param>
  		<param name="b" store="auto">
  			<long/>
  		</param>
  		<body>
  			<return>
  				<add>
  					<get ref="a"/>
  					<get ref="b"/>
  				</add>
  			</return>
  		</body>
  	</fundef>
  	<fundec id="sum_internal_3" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="a" store="auto">
  			<long/>
  		</param>
  		<param name="b" store="auto">
  			<long/>
  		</param>
  	</fundec>
  	<fundef id="sum_internal_2" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="a" store="auto">
  			<long/>
  		</param>
  		<param name="b" store="auto">
  			<long/>
  		</param>
  		<body>
  			<var id="c" store="auto">
  				<long/>
  				<call>
  					<get ref="sum_internal_3"/>
  					<get ref="a"/>
  					<int>42</int>
  				</call>
  			</var>
  			<return>
  				<add>
  					<call>
  						<get ref="sum_internal_1"/>
  						<get ref="a"/>
  						<get ref="b"/>
  					</call>
  					<get ref="c"/>
  				</add>
  			</return>
  		</body>
  	</fundef>
  	<fundec id="sum_external" store="extern">
  		<type>
  			<long/>
  		</type>
  		<param name="a" store="auto">
  			<long/>
  		</param>
  		<param name="b" store="auto">
  			<long/>
  		</param>
  	</fundec>
  </file>
  $ ctoxml symexec-crc32.c
  <?xml version="1.0" encoding="iso-8859-1" standalone="yes"?>
  <file>
  	<fundef id="crc32" store="auto">
  		<type>
  			<ulong/>
  		</type>
  		<param name="message" store="auto">
  			<ptr>
  				<uchar/>
  			</ptr>
  		</param>
  		<body>
  			<var id="i" store="auto">
  				<long/>
  			</var>
  			<var id="j" store="auto">
  				<long/>
  			</var>
  			<var id="byte" store="auto">
  				<ulong/>
  			</var>
  			<var id="crc" store="auto">
  				<ulong/>
  			</var>
  			<var id="mask" store="auto">
  				<ulong/>
  			</var>
  			<set>
  				<get ref="i"/>
  				<int>0</int>
  			</set>
  			<set>
  				<get ref="crc"/>
  				<int>0xFFFFFFFF</int>
  			</set>
  			<while>
  				<ne>
  					<index>
  						<get ref="message"/>
  						<get ref="i"/>
  					</index>
  					<int>0</int>
  				</ne>
  				<block>
  					<set>
  						<get ref="byte"/>
  						<index>
  							<get ref="message"/>
  							<get ref="i"/>
  						</index>
  					</set>
  					<set>
  						<get ref="crc"/>
  						<xor>
  							<get ref="crc"/>
  							<get ref="byte"/>
  						</xor>
  					</set>
  					<for>
  						<set>
  							<get ref="j"/>
  							<int>7</int>
  						</set>
  						<ge>
  							<get ref="j"/>
  							<int>0</int>
  						</ge>
  						<postdec>
  							<get ref="j"/>
  						</postdec>
  						<block>
  							<set>
  								<get ref="mask"/>
  								<neg>
  									<band>
  										<get ref="crc"/>
  										<int>1</int>
  									</band>
  								</neg>
  							</set>
  							<set>
  								<get ref="crc"/>
  								<xor>
  									<shr>
  										<get ref="crc"/>
  										<int>1</int>
  									</shr>
  									<band>
  										<int>0xEDB88320</int>
  										<get ref="mask"/>
  									</band>
  								</xor>
  							</set>
  						</block>
  					</for>
  					<set>
  						<get ref="i"/>
  						<add>
  							<get ref="i"/>
  							<int>1</int>
  						</add>
  					</set>
  				</block>
  			</while>
  			<return>
  				<bnot>
  					<get ref="crc"/>
  				</bnot>
  			</return>
  		</body>
  	</fundef>
  	<fundef id="main" store="auto">
  		<type>
  			<long/>
  		</type>
  		<body>
  			<var id="buf1" store="auto">
  				<array>
  					<char/>
  					<size>
  						<int>16</int>
  					</size>
  				</array>
  			</var>
  			<var id="buf2" store="auto">
  				<array>
  					<char/>
  					<size>
  						<int>16</int>
  					</size>
  				</array>
  			</var>
  			<if>
  				<and>
  					<call>
  						<get ref="fgets"/>
  						<get ref="buf1"/>
  						<sizeof>
  							<get ref="buf1"/>
  						</sizeof>
  						<get ref="stdin"/>
  					</call>
  					<call>
  						<get ref="fgets"/>
  						<get ref="buf2"/>
  						<sizeof>
  							<get ref="buf2"/>
  						</sizeof>
  						<get ref="stdin"/>
  					</call>
  				</and>
  				<block>
  					<if>
  						<eq>
  							<call>
  								<get ref="crc32"/>
  								<get ref="buf1"/>
  							</call>
  							<call>
  								<get ref="crc32"/>
  								<get ref="buf2"/>
  							</call>
  						</eq>
  						<block>
  							<call>
  								<get ref="puts"/>
  								<string>access granted</string>
  							</call>
  						</block>
  						<nop/>
  					</if>
  				</block>
  				<nop/>
  			</if>
  		</body>
  	</fundef>
  </file>
  $ ctoxml symexec-faux.c
  <?xml version="1.0" encoding="iso-8859-1" standalone="yes"?>
  <file>
  	<var id="sneaky" store="auto">
  		<ptr>
  			<char/>
  		</ptr>
  		<string>SOSNEAKY</string>
  	</var>
  	<fundef id="accepted" store="auto">
  		<type>
  			<long/>
  		</type>
  		<body>
  			<call>
  				<get ref="puts"/>
  				<string>access granted!</string>
  			</call>
  			<call>
  				<get ref="exit"/>
  				<int>0</int>
  			</call>
  		</body>
  	</fundef>
  	<fundef id="rejected" store="auto">
  		<type>
  			<long/>
  		</type>
  		<body>
  			<call>
  				<get ref="exit"/>
  				<int>1</int>
  			</call>
  		</body>
  	</fundef>
  	<fundef id="authenticate" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="username" store="auto">
  			<ptr>
  				<char/>
  			</ptr>
  		</param>
  		<param name="password" store="auto">
  			<ptr>
  				<char/>
  			</ptr>
  		</param>
  		<body>
  			<var id="entry" store="auto">
  				<array>
  					<char/>
  					<size>
  						<add>
  							<mul>
  								<get ref="BUFSIZE"/>
  								<int>2</int>
  							</mul>
  							<int>2</int>
  						</add>
  					</size>
  				</array>
  			</var>
  			<mul>
  				<get ref="FILE"/>
  				<get ref="pwfile"/>
  			</mul>
  			<if>
  				<eq>
  					<call>
  						<get ref="strcmp"/>
  						<get ref="password"/>
  						<get ref="sneaky"/>
  					</call>
  					<int>0</int>
  				</eq>
  				<return>
  					<int>1</int>
  				</return>
  				<nop/>
  			</if>
  			<set>
  				<get ref="pwfile"/>
  				<call>
  					<get ref="fopen"/>
  					<string>passwd</string>
  					<string>r</string>
  				</call>
  			</set>
  			<if>
  				<not>
  					<get ref="pwfile"/>
  				</not>
  				<call>
  					<get ref="rejected"/>
  				</call>
  				<nop/>
  			</if>
  			<while>
  				<call>
  					<get ref="fgets"/>
  					<get ref="entry"/>
  					<sizeof>
  						<get ref="entry"/>
  					</sizeof>
  					<get ref="pwfile"/>
  				</call>
  				<block>
  					<var id="secret" store="auto">
  						<ptr>
  							<char/>
  						</ptr>
  						<get ref="NULL"/>
  					</var>
  					<set>
  						<get ref="secret"/>
  						<call>
  							<get ref="strpbrk"/>
  							<get ref="entry"/>
  							<string>:</string>
  						</call>
  					</set>
  					<if>
  						<get ref="secret"/>
  						<block>
  							<set>
  								<memof>
  									<postinc>
  										<get ref="secret"/>
  									</postinc>
  								</memof>
  								<char> </char>
  							</set>
  							<set>
  								<index>
  									<get ref="secret"/>
  									<sub>
  										<call>
  											<get ref="strlen"/>
  											<get ref="secret"/>
  										</call>
  										<int>1</int>
  									</sub>
  								</index>
  								<char> </char>
  							</set>
  							<if>
  								<and>
  									<eq>
  										<call>
  											<get ref="strcmp"/>
  											<get ref="entry"/>
  											<get ref="username"/>
  										</call>
  										<int>0</int>
  									</eq>
  									<eq>
  										<call>
  											<get ref="strcmp"/>
  											<get ref="secret"/>
  											<get ref="password"/>
  										</call>
  										<int>0</int>
  									</eq>
  								</and>
  								<block>
  									<return>
  										<int>1</int>
  									</return>
  								</block>
  								<nop/>
  							</if>
  						</block>
  						<nop/>
  					</if>
  				</block>
  			</while>
  			<return>
  				<int>0</int>
  			</return>
  		</body>
  	</fundef>
  	<fundef id="strip" store="auto">
  		<type>
  			<void/>
  		</type>
  		<param name="s" store="auto">
  			<ptr>
  				<char/>
  			</ptr>
  		</param>
  		<body>
  			<var id="n" store="auto">
  				<long/>
  				<call>
  					<get ref="strlen"/>
  					<get ref="s"/>
  				</call>
  			</var>
  			<set>
  				<index>
  					<get ref="s"/>
  					<get ref="n"/>
  				</index>
  				<quest>
  					<eq>
  						<index>
  							<get ref="s"/>
  							<get ref="n"/>
  						</index>
  						<char>
  </char>
  					</eq>
  					<char> </char>
  					<index>
  						<get ref="s"/>
  						<get ref="n"/>
  					</index>
  				</quest>
  			</set>
  		</body>
  	</fundef>
  	<fundef id="main" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="argc" store="auto">
  			<long/>
  		</param>
  		<param name="argv" store="auto">
  			<ptr>
  				<ptr>
  					<char/>
  				</ptr>
  			</ptr>
  		</param>
  		<body>
  			<var id="username" store="auto">
  				<array>
  					<char/>
  					<size>
  						<get ref="BUFSIZE"/>
  					</size>
  				</array>
  			</var>
  			<var id="password" store="auto">
  				<array>
  					<char/>
  					<size>
  						<get ref="BUFSIZE"/>
  					</size>
  				</array>
  			</var>
  			<if>
  				<not>
  					<call>
  						<get ref="fgets"/>
  						<get ref="username"/>
  						<sizeof>
  							<get ref="username"/>
  						</sizeof>
  						<get ref="stdin"/>
  					</call>
  				</not>
  				<call>
  					<get ref="rejected"/>
  				</call>
  				<nop/>
  			</if>
  			<if>
  				<not>
  					<call>
  						<get ref="fgets"/>
  						<get ref="password"/>
  						<sizeof>
  							<get ref="password"/>
  						</sizeof>
  						<get ref="stdin"/>
  					</call>
  				</not>
  				<call>
  					<get ref="rejected"/>
  				</call>
  				<nop/>
  			</if>
  			<call>
  				<get ref="strip"/>
  				<get ref="username"/>
  			</call>
  			<call>
  				<get ref="strip"/>
  				<get ref="password"/>
  			</call>
  			<if>
  				<call>
  					<get ref="authenticate"/>
  					<get ref="username"/>
  					<get ref="password"/>
  				</call>
  				<call>
  					<get ref="accepted"/>
  				</call>
  				<call>
  					<get ref="rejected"/>
  				</call>
  			</if>
  		</body>
  	</fundef>
  </file>
  $ ctoxml symexec-guess.c
  <?xml version="1.0" encoding="iso-8859-1" standalone="yes"?>
  <file>
  	<fundef id="main" store="auto">
  		<type>
  			<long/>
  		</type>
  		<body>
  			<if>
  				<eq>
  					<call>
  						<get ref="getchar"/>
  					</call>
  					<char>A</char>
  				</eq>
  				<block>
  					<call>
  						<get ref="puts"/>
  						<string>access granted</string>
  					</call>
  				</block>
  				<nop/>
  			</if>
  		</body>
  	</fundef>
  </file>
  $ ctoxml symexec-guess-many-tries.c
  <?xml version="1.0" encoding="iso-8859-1" standalone="yes"?>
  <file>
  	<fundef id="main" store="auto">
  		<type>
  			<long/>
  		</type>
  		<body>
  			<while>
  				<int>1</int>
  				<block>
  					<var id="c" store="auto">
  						<long/>
  						<call>
  							<get ref="getchar"/>
  						</call>
  					</var>
  					<if>
  						<eq>
  							<get ref="c"/>
  							<char>A</char>
  						</eq>
  						<block>
  							<call>
  								<get ref="puts"/>
  								<string>access granted</string>
  							</call>
  							<return>
  								<int>0</int>
  							</return>
  						</block>
  						<nop/>
  					</if>
  					<if>
  						<le>
  							<get ref="c"/>
  							<int>0</int>
  						</le>
  						<block>
  							<return>
  								<int>1</int>
  							</return>
  						</block>
  						<nop/>
  					</if>
  					<if>
  						<eq>
  							<get ref="c"/>
  							<char>
  </char>
  						</eq>
  						<block>
  							<continue/>
  						</block>
  						<nop/>
  					</if>
  				</block>
  			</while>
  		</body>
  	</fundef>
  </file>
  $ ctoxml symexec-guess-many-tries-switch.c
  <?xml version="1.0" encoding="iso-8859-1" standalone="yes"?>
  <file>
  	<fundef id="main" store="auto">
  		<type>
  			<long/>
  		</type>
  		<body>
  			<while>
  				<int>1</int>
  				<block>
  					<switch>
  						<call>
  							<get ref="getchar"/>
  						</call>
  						<block>
  							<case>
  								<bor>
  									<neg>
  										<int>1</int>
  									</neg>
  									<int>0</int>
  								</bor>
  								<call>
  									<get ref="puts"/>
  									<string>good bye!</string>
  								</call>
  							</case>
  							<return>
  								<int>1</int>
  							</return>
  							<case>
  								<char>A</char>
  								<call>
  									<get ref="puts"/>
  									<string>access granted</string>
  								</call>
  							</case>
  							<return>
  								<int>0</int>
  							</return>
  							<case>
  								<char>
  </char>
  								<continue/>
  							</case>
  						</block>
  					</switch>
  				</block>
  			</while>
  		</body>
  	</fundef>
  </file>
  $ ctoxml symexec-input.c
  <?xml version="1.0" encoding="iso-8859-1" standalone="yes"?>
  <file>
  	<fundef id="main" store="auto">
  		<type>
  			<long/>
  		</type>
  		<body>
  			<var id="buf" store="auto">
  				<array>
  					<char/>
  					<size>
  						<int>16</int>
  					</size>
  				</array>
  			</var>
  			<mul>
  				<get ref="FILE"/>
  				<get ref="input"/>
  			</mul>
  			<and>
  				<and>
  					<and>
  						<set>
  							<get ref="input"/>
  							<call>
  								<get ref="fopen"/>
  								<string>passwd</string>
  								<string>r</string>
  							</call>
  						</set>
  						<call>
  							<get ref="fgets"/>
  							<get ref="buf"/>
  							<sizeof>
  								<get ref="buf"/>
  							</sizeof>
  							<get ref="input"/>
  						</call>
  					</and>
  					<eq>
  						<call>
  							<get ref="strncmp"/>
  							<get ref="buf"/>
  							<string>backdoor</string>
  							<int>8</int>
  						</call>
  						<int>0</int>
  					</eq>
  				</and>
  				<call>
  					<get ref="puts"/>
  					<string>access granted</string>
  				</call>
  			</and>
  		</body>
  	</fundef>
  </file>
  $ ctoxml symexec-palindrome.c
  <?xml version="1.0" encoding="iso-8859-1" standalone="yes"?>
  <file>
  	<fundef id="main" store="auto">
  		<type>
  			<long/>
  		</type>
  		<body>
  			<var id="buf" store="auto">
  				<array>
  					<char/>
  					<size>
  						<int>8</int>
  					</size>
  				</array>
  			</var>
  			<if>
  				<call>
  					<get ref="fgets"/>
  					<get ref="buf"/>
  					<sizeof>
  						<get ref="buf"/>
  					</sizeof>
  					<get ref="stdin"/>
  				</call>
  				<block>
  					<var id="i" store="auto">
  						<long/>
  					</var>
  					<var id="n" store="auto">
  						<long/>
  						<sub>
  							<call>
  								<get ref="strlen"/>
  								<get ref="buf"/>
  							</call>
  							<int>1</int>
  						</sub>
  					</var>
  					<for>
  						<set>
  							<get ref="i"/>
  							<int>0</int>
  						</set>
  						<and>
  							<and>
  								<gt>
  									<get ref="n"/>
  									<int>2</int>
  								</gt>
  								<le>
  									<get ref="i"/>
  									<div>
  										<get ref="n"/>
  										<int>2</int>
  									</div>
  								</le>
  							</and>
  							<eq>
  								<index>
  									<get ref="buf"/>
  									<get ref="i"/>
  								</index>
  								<index>
  									<get ref="buf"/>
  									<sub>
  										<sub>
  											<get ref="n"/>
  											<get ref="i"/>
  										</sub>
  										<int>1</int>
  									</sub>
  								</index>
  							</eq>
  						</and>
  						<postinc>
  							<get ref="i"/>
  						</postinc>
  						<nop/>
  					</for>
  					<if>
  						<gt>
  							<get ref="i"/>
  							<div>
  								<get ref="n"/>
  								<int>2</int>
  							</div>
  						</gt>
  						<block>
  							<call>
  								<get ref="puts"/>
  								<string>access granted!</string>
  							</call>
  						</block>
  						<nop/>
  					</if>
  				</block>
  				<nop/>
  			</if>
  		</body>
  	</fundef>
  </file>
  $ ctoxml symexec-simple.c
  <?xml version="1.0" encoding="iso-8859-1" standalone="yes"?>
  <file>
  	<fundef id="main" store="auto">
  		<type>
  			<long/>
  		</type>
  		<body>
  			<var id="buf" store="auto">
  				<array>
  					<char/>
  					<size>
  						<int>16</int>
  					</size>
  				</array>
  			</var>
  			<var id="bytes_read" store="auto">
  				<long/>
  				<call>
  					<get ref="read"/>
  					<int>0</int>
  					<get ref="buf"/>
  					<sub>
  						<sizeof>
  							<get ref="buf"/>
  						</sizeof>
  						<int>1</int>
  					</sub>
  				</call>
  			</var>
  			<if>
  				<ne>
  					<get ref="bytes_read"/>
  					<neg>
  						<int>1</int>
  					</neg>
  				</ne>
  				<block>
  					<set>
  						<index>
  							<get ref="buf"/>
  							<get ref="bytes_read"/>
  						</index>
  						<int>0</int>
  					</set>
  					<if>
  						<eq>
  							<call>
  								<get ref="strcmp"/>
  								<get ref="buf"/>
  								<string>backdoor</string>
  							</call>
  							<int>0</int>
  						</eq>
  						<block>
  							<call>
  								<get ref="puts"/>
  								<string>access granted!</string>
  							</call>
  						</block>
  						<nop/>
  					</if>
  				</block>
  				<nop/>
  			</if>
  		</body>
  	</fundef>
  </file>
  $ ctoxml trivial.c
  <?xml version="1.0" encoding="iso-8859-1" standalone="yes"?>
  <file>
  	<fundef id="main" store="auto">
  		<type>
  			<long/>
  		</type>
  		<param name="argc" store="auto">
  			<long/>
  		</param>
  		<param name="argv" store="auto">
  			<array>
  				<ptr>
  					<const>
  						<char/>
  					</const>
  				</ptr>
  				<size>
  					<nothing/>
  				</size>
  			</array>
  		</param>
  		<body>
  			<var id="i" store="auto">
  				<long/>
  			</var>
  			<for>
  				<set>
  					<get ref="i"/>
  					<int>0</int>
  				</set>
  				<lt>
  					<get ref="i"/>
  					<get ref="argc"/>
  				</lt>
  				<postinc>
  					<get ref="i"/>
  				</postinc>
  				<block>
  					<call>
  						<get ref="puts"/>
  						<index>
  							<get ref="argv"/>
  							<get ref="i"/>
  						</index>
  					</call>
  				</block>
  			</for>
  			<call>
  				<get ref="abort"/>
  			</call>
  		</body>
  	</fundef>
  </file>

  $ ctoxml anonymous-structs.c
  <?xml version="1.0" encoding="iso-8859-1" standalone="yes"?>
  <file>
  	<struct id="struct:Scope">
  		<field name="">
  			<union>
  				<field name="alpha">
  					<char/>
  				</field>
  				<field name="num">
  					<long/>
  				</field>
  			</union>
  		</field>
  	</struct>
  	<struct id="struct:Scope2">
  		<field name="">
  			<struct>
  				<field name="alpha">
  					<char/>
  				</field>
  				<field name="num">
  					<long/>
  				</field>
  			</struct>
  		</field>
  	</struct>
  </file>

  $ ctoxml atomic_parenthesis.c
  <?xml version="1.0" encoding="iso-8859-1" standalone="yes"?>
  <file>
  	<var id="_Atomic" store="auto">
  		<fun>
  			<vararg/>
  		</fun>
  	</var>
  </file>
  $ ctoxml dangling_else.c
  <?xml version="1.0" encoding="iso-8859-1" standalone="yes"?>
  <file>
  	<fundef id="f" store="auto">
  		<type>
  			<long/>
  		</type>
  		<body>
  			<if>
  				<int>0</int>
  				<if>
  					<int>1</int>
  					<return>
  						<int>1</int>
  					</return>
  					<return>
  						<int>0</int>
  					</return>
  				</if>
  				<nop/>
  			</if>
  			<return>
  				<int>1</int>
  			</return>
  		</body>
  	</fundef>
  </file>
  $ ctoxml enum.c
  <?xml version="1.0" encoding="iso-8859-1" standalone="yes"?>
  <file>
  	<type id="foo" store="auto">
  		<enum>
  			<value name="a">
  				<nothing/>
  			</value>
  			<value name="b">
  				<get ref="a"/>
  			</value>
  		</enum>
  	</type>
  </file>
  $ ctoxml struct-recursion.c
  <?xml version="1.0" encoding="iso-8859-1" standalone="yes"?>
  <file>
  	<struct id="struct:s1">
  		<field name="A">
  			<ptr>
  				<struct ref="struct:s2"/>
  			</ptr>
  		</field>
  	</struct>
  	<struct id="struct:s2">
  		<field name="B">
  			<ptr>
  				<struct ref="struct:s1"/>
  			</ptr>
  		</field>
  	</struct>
  	<var id="a" store="auto">
  		<struct ref="struct:s1"/>
  	</var>
  	<var id="b" store="auto">
  		<struct ref="struct:s2"/>
  	</var>
  </file>
  $ ctoxml c99-struct-initializers.c
  <?xml version="1.0" encoding="iso-8859-1" standalone="yes"?>
  <file>
  	<struct id="struct:point">
  		<field name="x">
  			<long/>
  		</field>
  		<field name="y">
  			<long/>
  		</field>
  	</struct>
  	<struct id="struct:point3d">
  		<field name="x">
  			<long/>
  		</field>
  		<field name="y">
  			<long/>
  		</field>
  		<field name="z">
  			<long/>
  		</field>
  	</struct>
  	<fundef id="main" store="auto">
  		<type>
  			<long/>
  		</type>
  		<body>
  			<var id="p" store="auto">
  				<struct ref="struct:point"/>
  				<compound>
  					<designated name="y">
  						<int>2</int>
  					</designated>
  					<designated name="x">
  						<int>1</int>
  					</designated>
  				</compound>
  			</var>
  			<var id="p2" store="auto">
  				<struct ref="struct:point3d"/>
  				<compound>
  					<designated name="z">
  						<int>2</int>
  					</designated>
  					<designated name="x">
  						<int>1</int>
  					</designated>
  					<int>5</int>
  				</compound>
  			</var>
  			<nop/>
  		</body>
  	</fundef>
  </file>

  $ ctoxml complex-pre.c
  <?xml version="1.0" encoding="iso-8859-1" standalone="yes"?>
  <file>
  	<fundef id="main" store="auto">
  		<type>
  			<long/>
  		</type>
  		<body>
  			<var id="z1" store="auto">
  				<cdouble/>
  				<add>
  					<float>0.0</float>
  					<mul>
  						<call>
  							<get ref="__builtin_inff"/>
  						</call>
  						<get ref="_Imaginary_I"/>
  					</mul>
  				</add>
  			</var>
  			<var id="z2" store="auto">
  				<cdouble/>
  				<add>
  					<float>0.0</float>
  					<mul>
  						<call>
  							<get ref="__builtin_inff"/>
  						</call>
  						<float>1.0iF</float>
  					</mul>
  				</add>
  			</var>
  			<call>
  				<get ref="printf"/>
  				<string>z1 = %.1f%+.1fi
  </string>
  				<call>
  					<get ref="creal"/>
  					<get ref="z1"/>
  				</call>
  				<call>
  					<get ref="cimag"/>
  					<get ref="z1"/>
  				</call>
  			</call>
  			<call>
  				<get ref="printf"/>
  				<string>z2 = %.1f%+.1fi
  </string>
  				<call>
  					<get ref="creal"/>
  					<get ref="z2"/>
  				</call>
  				<call>
  					<get ref="cimag"/>
  					<get ref="z2"/>
  				</call>
  			</call>
  		</body>
  	</fundef>
  </file>

  $ echo 'void fn(char xs[const static volatile]) {}' | ctoxml --
  <?xml version="1.0" encoding="iso-8859-1" standalone="yes"?>
  <file>
  	<fundef id="fn" store="auto">
  		<type>
  			<void/>
  		</type>
  		<param name="xs" store="auto">
  			<volatile>
  				<const>
  					<array>
  						<char/>
  						<size>
  							<nothing/>
  						</size>
  					</array>
  				</const>
  			</volatile>
  		</param>
  		<body>
  			<nop/>
  		</body>
  	</fundef>
  </file>
  $ echo 'void fn(char xs[const static volatile 10]) {}' | ctoxml
  <?xml version="1.0" encoding="iso-8859-1" standalone="yes"?>
  <file>
  	<fundef id="fn" store="auto">
  		<type>
  			<void/>
  		</type>
  		<param name="xs" store="auto">
  			<volatile>
  				<const>
  					<array>
  						<char/>
  						<size>
  							<int>10</int>
  						</size>
  					</array>
  				</const>
  			</volatile>
  		</param>
  		<body>
  			<nop/>
  		</body>
  	</fundef>
  </file>

  $ echo 'struct s {int : 32;};' | ctoxml
  <?xml version="1.0" encoding="iso-8859-1" standalone="yes"?>
  <file>
  	<struct id="struct:s">
  		<field name="">
  			<bits>
  				<int>32</int>
  			</bits>
  		</field>
  	</struct>
  </file>
