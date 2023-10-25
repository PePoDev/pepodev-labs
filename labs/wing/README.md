# Hello Wing

## Wing console

```sh
wing it hello.w
```

## Compile

```sh
wing compile --target tf-aws hello.w

cd ./target/cdktf.out/stacks/root
export AWS_REGION=us-east-1 # or any other region
terraform init
terraform apply
```

## Testing

```sh
# Compile the wing file to the simulator
wing compile -t sim hello.w

# Load node console
node --experimental-repl-await

# Install winglang sdk
npm i @winglang/sdk

# Create instance of simulator
const sdk = require("@winglang/sdk");
const simulator = new sdk.testing.Simulator({ simfile : "./target/hello.wsim"});
await simulator.start();

# Push a message to the queue
const queue = simulator.getResource("root/cloud.Queue");
await queue.push("Wing")

# view the file on the bucket
const bucket = simulator.getResource("root/cloud.Bucket");
await bucket.list()
await bucket.get("wing.txt")
```
