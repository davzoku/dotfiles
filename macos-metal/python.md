## Installation

```
brew install miniconda
```

### tensorflow

```
mkdir tensorflow-test
cd tensorflow-test
```

```
conda create --prefix ./env python=3.8
conda activate ./env
```

```
conda install -c apple tensorflow-deps
python -m pip install tensorflow-macos
python -m pip install tensorflow-metal
conda install jupyter pandas numpy matplotlib scikit-learn
```

### pytorch

## References

- [Setting up new M2 MacBook for my software development - YouTube](https://www.youtube.com/watch?v=mmkDyV59nRo)
- [Setup Apple Silicon Mac for Machine Learning in 13 minutes (TensorFlow edition) - YouTube](https://www.youtube.com/watch?v=_1CaUOHhI6U)
- [Setup Apple Silicon Mac for Machine Learning in 11 minutes (PyTorch edition) - YouTube](https://www.youtube.com/watch?v=Zx2MHdRgAIc)
- [How To Setup A MacBook Pro M1 For Software Development - YouTube](https://www.youtube.com/watch?v=5eSaJGSGLs0)
- [mrdbourke/m1-machine-learning-test: Code for testing various M1 Chip benchmarks with TensorFlow.](https://github.com/mrdbourke/m1-machine-learning-test)
