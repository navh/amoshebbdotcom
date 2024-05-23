---
title: "Use Jax on Compute Canada/Digital Research Alliance of Canada"
date: 2024-05-02T13:45:59-04:00
tags: ["jax"]
---


I've had luck getting GPUs quickly on `graham.computecanada.ca`, so I suggest you use something else. 

On the login node:

Previously I was explicitly specifying a new StdEnv, but for now, the latest one is the default. This is not necessary right now but for future reference.
```bash
module load StdEnv/2023
```

Figure grab the least stale python and cuda 
```bash
module spider python
module spider cuda
```

Grab specific versions
```bash
module load python/3.11.5
module load cuda/12.2
```

Or if you're feeling lucky, I usually just module load python cuda

Create a Python virtual environment, I'll name it `jaxenv`

```bash
python -m venv ~/jaxenv 
```

Activate and update it, using `--no-index` goes after cluster-built wheels, preventing dependency hell.

```bash
source ~/jaxenv/bin/activate

python -m pip install --upgrade pip --no-index

python -m pip install jax --no-index
```

Get an interactive session with a GPU just to kick the tires. 

```bash
salloc --time=0:20:00 --mem=3500 --gres=gpu:1 --account=def-rsadve
```

Once you're in that worker's shell

```bash
source ~/jaxenv/bin/activate

python
```

Once you've got an interactive Python session

```python
from jax.lib import xla_bridge
print(xla_bridge.get_backend().platform)
```

should say GPU.

Then sometimes I'll run a little GPU code to see if anything exciting blows up. 

In an interactive session with a GPU attached:

```python
import jax.numpy as jnp
from jax import grad, jit, vmap, random
key = random.key(0)
x = random.normal(key, (3000,3000), dtype=jnp.float32)
jnp.dot(x, x.T).block_until_ready() # runs on the GPU
```



