import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  stages: [
    { duration: '30s', target: 20 },  // ramp up
    { duration: '1m',  target: 20 },  // steady state
    { duration: '10s', target: 0  },  // ramp down
  ],
  thresholds: {
    http_req_duration: ['p(95)<200'],
    http_req_failed:   ['rate<0.01'],
  },
};

const BASE_URL = __ENV.BASE_URL || 'http://localhost:8080';

export default function () {
  const res = http.get(`${BASE_URL}/health`);
  check(res, {
    'status is 200':          (r) => r.status === 200,
    'response time < 200ms':  (r) => r.timings.duration < 200,
  });
  sleep(1);
}
