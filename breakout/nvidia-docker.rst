**NVIDIA-Docker**
=================

Background
~~~~~~~~~~

NVIDIA is one of the leading makers of graphic processing units (GPU). GPU were established as a means of handling graphics processing operations for video cards, but have been greatly expanded for use in generalized computing applications. GPU are used for various applications in Machine Learning, image processing, and matrix-based linear algebras.

NVIDIA Docker
~~~~~~~~~~~~~

|NVIDIA-docker-diagram|

NVIDIA have created their own set of Docker containers for running on CPU-GPU enabled systems.

`NVIDIA-Docker <xhttps://github.com/NVIDIA/nvidia-docker>`_ runs atop the NVIDIA graphics drivers on the host system, the NVIDIA drivers are imported to the container at runtime.

`NVIDIA Docker Hub <https://hub.docker.com/u/nvidia>`_ hosts numerous NVIDIA Docker containers, from which you can build your own images.

NVIDIA GPU Cloud
~~~~~~~~~~~~~~~~

`NVIDIA GPU Cloud <https://ngc.nvidia.com>`_ hosts numerous containers for HPC and Cloud applications. You must register an account with them (free) to access these. 

Registry
^^^^^^^^

NVIDIA GPU Cloud hosts three `registry spaces <https://docs.nvidia.com/ngc/ngc-user-guide/ngc-spaces.html#ngc-spaces>`_

  * `nvcr.io/nvidia` - catalog of fully integrated and optimized deep learning framework containers.
  * `nvcr.io/nvidia-hpcvis` - catalog of HPC visualization containers (beta).
  * `nvcr.io/hpc` -  popular third-party GPU ready HPC application containers.

Running NVIDIA Docker with Singularity
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You can run NVIDIA Docker on HPC by using Singularity, but it requires a few steps, including authentication to NVIDIA GPU cloud.

`NVIDIA to Singularity Official YouTube demo <https://youtu.be/iOLVqqHQsBU>`_

Running GPU accelarated GUI applications with NVIDIA-Docker
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

NVIDIA Docker can be used as a base-image to create containers running graphical applications remotely. High resolution 3D screens are piped to a remote desktop platform.

Programs which leverage 3D applications include `VirtualGL <https://www.virtualgl.org/>`_, `TurboVNC <https://www.turbovnc.org/>`_, & `TigerVNC <https://tigervnc.org/>`_.

An example application of a graphics-enabled remote desktop is the use of `Blender <https://www.blender.org/>`_ for creating high level of detail images or animations.

.. |NVIDIA-docker-diagram| image:: https://cloud.githubusercontent.com/assets/3028125/12213714/5b208976-b632-11e5-8406-38d379ec46aa.png  
                           :width: 800
    
