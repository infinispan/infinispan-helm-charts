import org.infinispan.client.hotrod.configuration.ClientIntelligence;
import org.infinispan.client.hotrod.configuration.ConfigurationBuilder;
import org.infinispan.client.hotrod.configuration.SaslQop;
...

ConfigurationBuilder builder = new ConfigurationBuilder();
      builder.addServer()
               .host("$SERVICE_HOSTNAME")
               .port("$PORT")
             .security().authentication()
               .username("username")
               .password("changeme")
               .realm("default")
               .saslQop(SaslQop.AUTH)
               .saslMechanism("SCRAM-SHA-512");
      builder.clientIntelligence(ClientIntelligence.BASIC);
