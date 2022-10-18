# Build MSF Module
For general information about Metasploit see [[Metasploit]]. Check out [[Useful_Ruby]] for a more hacker [XinYminutes](https://learnxinyminutes.com/docs/ruby/)

```ruby
class MetasploitModule < Msf::Exploit::LIBRARY
  Rank = Ranking
	
	include Msf::Exploit::LIBRARY::FUNCTIONALITY

	def initialize(info = {})
    	super(update_info(info,
		# Header information:
		'Name'           => 'Exploit name Goes Here',
		'Description'    => %q(
			Description goes here.
			),
		'License'        => MSF_LICENSE,
		'Author'         => [ 'Author one', 'Author two' ],
		'References'     => 
			[
    			[ 'EDB', 'ExploitDB Number goes here as digits' ]
  			],
		# Default option section:
		'DefaultOptions' =>
  			{
    			'EXITFUNC' => 'thread'
  			},
		'Platform'       => 'win',
		'Payload'        =>
  			{
    		'Payload Option' => "These being relative to exploit",
  			},
		'Targets'        =>
  		[
    		[ 'Exploit Target Name And Numeric Version',
      			{
        		'Ret' => DefaultReturn
        		'AnotherRet' => AnotherDefaultReturn
      		}]
  		],
      'Privileged'     => true,
      'DisclosureDate' => 'MonthThreeLetter DayNumber Year',
      'DefaultTarget'  => 0))
	
   register_options([Opt::RPORT(80)])
end
```

Check functionality to check if target is vulnerable:
```ruby
  def check
    res = send_request(
      'uri'    =>  '/',
      'method' =>  'GET'
    )

    if res && res.code == 200
	    vuln_indicator = res.body.scan('For some string').flatten.first
	    if some_check =~ vuln_indicator
      		return Exploit::CheckCode::Appears
    	end
    end

    return Exploit::CheckCode::Safe
  end
```

Then exploit code remember that it is class behaviour and requires closing with an additional `end`
```ruby
	def exploit
		#do stuff
		
		handler
		disconnect
	end
end
```