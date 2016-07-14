from setuptools import setup

setup(
    name='Streaming-Toolbelt',
    version='1.0',
    description='Run a Docker container filled with the necessary streaming tools',
    author='Jonas Birme',
    author_email='jonas.birme@eyevinn.se',
    url='https://github.com/Eyevinn/docker-toolbelt', 
    scripts = [
        'bin/streaming-toolbelt'
    ]
)
