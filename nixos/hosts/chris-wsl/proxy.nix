{ ... }: let 
  proxy = "http://10.56.4.40:8080" 
  in { 
   networking.proxy.default = proxy;
  virtualisation.docker.daemon.settings = {  
    'proxies': {
      'http-proxy': proxy,
      'https-proxy': proxy,
      'no-proxy': '' 
    }
  }; 
}
