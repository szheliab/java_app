package rd.pingable.rest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.actuate.jdbc.DataSourceHealthIndicator;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.LinkedHashMap;
import java.util.Map;

@RestController("/health")
public class HealthController {

    @Autowired
    private DataSourceHealthIndicator healthIndicator;

    @GetMapping
    public Map<String, Object> health() {
        return buildHealth();
    }

    private Map<String, Object> buildHealth() {
        Map<String, Object> hashMap = new LinkedHashMap<>();
        hashMap.put("status", "UP");
        hashMap.put("db", healthIndicator.health());
        return hashMap;
    }
}
