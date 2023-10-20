# Ruby

Use can use Ruby to [[Build-MSF-Modules]].

Ruby web server
```bash
ruby -run -e httpd . -p 9000
```


If for example you have restricted CMDi([[Command-Injection-Cheatsheet]])  and need to enumerate the Ruby Version try `rake`. ref. [Conor Livingston](https://stackoverflow.com/questions/12979343/how-to-find-out-which-rails-version-an-existing-rails-application-is-built-on):
```bash 
rake about
```

#### Virtual Environment

[Ruby Virtual Environment Rbenv](https://medium.com/@bhagavathidhass/virtual-environments-for-python-ruby-and-java-87743478ae38):
```bash
rbenv init   # initialize rbenv  
rbenv install -l  # list all available versions  
rbenv install 2.0.0-p247 # install a Ruby version  
rbenv local 1.9.3-p327 # sets the local ruby version  
rbenv local -unset # unset the local version  
rbenv global 1.9.3-p327 # set the global system version of ruby  
rbenv versions # list all ruby versions known to rbenv  
rbenv shell 1.9.3 # set shell specific ruby.
```


## References

[Ruby Virtual Environment Rbenv](https://medium.com/@bhagavathidhass/virtual-environments-for-python-ruby-and-java-87743478ae38)
[Conor Livingston StackOverflow](https://stackoverflow.com/questions/12979343/how-to-find-out-which-rails-version-an-existing-rails-application-is-built-on)