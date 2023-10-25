bring cloud;

let bucket = new cloud.Bucket();
let queue = new cloud.Queue();
let counter = new cloud.Counter(initial: 100);

queue.on_message(inflight (message: str): str => {
  let next = counter.inc();
  let key = "myfile-${next}.txt";
  bucket.put(key, message);
  // bucket.put("wing.txt", "Hello, ${message}");
});
