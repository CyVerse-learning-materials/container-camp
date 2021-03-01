**Biocontainers in HPC**
==============================

On HPC systems, the traditional way to make software available is through the "modules" system.  The modules system allows administrators to install hundreds of scientific software packages on a system, including multiple versions of the same package, and then users can select the packages they want loaded into their environment.

Adding a package into the modules system can take a lot of work.  At TACC, the process of adding a module looks something like this:

#. Manually install the software on the system as a test to figure out the best compiler optimizations, account for any dependencies, etc.
#. Encode the installation process into an RPM file, add relevant metadata to the RPM, and craft a "modulefile" that lets the modules system discover the app.
#. Build the RPM and put the compiled package in a designated location.
#. Send a ticket to the administrators so that they can install the package during the next maintenance.
#. System administrators install the package through a scripted process that installs the package on the local harddrive on every node on the system (often thousands of nodes)
#. Next time users look for the package using the "modules" command, it will show up and be available for use.

.. Note::

  New systems are usually different enough from the old systems that RPM files must be altered manually every time, for every package.  TACC usually has 6-10 production systems that need scientific software RPMs. For examples of what goes into an RPM file, you can look in this `Github repository <https://github.com/TACC/lifesci_spec>`_


Installing thousands of apps on a cluster
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

As the BioContainers project has demonstrated, the Bioinformatics community alone uses thousands of software packages.  What can users of HPC systems do to gain access to the software they care about when the modules system cannot keep up?

Bjorn Gruning from the University of Freiburg, along with many many collaborators from the BioContainers community has championed the inclusion of Singularity images from the BioContainers project.  This means that every app with a Conda recipe also has a Singularity image for it.  They are publicly available via FTP here: `https://depot.galaxyproject.org/singularity/ <https://depot.galaxyproject.org/singularity/>`_

They are also already available on every TACC system on the global work filesystem in this directory:

.. code-block:: bash

  /work/projects/singularity/TACC/biocontainers/

There are **over 7200** Singularity images currently available in that directory.  (So be careful trying to do an "ls" command there! 

All the images are named in the format: name_version.img.  They were converted from Docker containers using the docker2singularity script that adds top level directories (like "/work") to make sure that volume mounts will work on the HPC systems.  If you use TACC, you can check for a software package, for example, bwa, like this:

.. code-block:: bash

  $ find /work/projects/singularity/TACC/biocontainers/ -name bwa*
  /work/projects/singularity/TACC/biocontainers/bwameth_0.20--py35_0.img
  /work/projects/singularity/TACC/biocontainers/bwa_0.5.9--0.img
  /work/projects/singularity/TACC/biocontainers/bwa_0.7.17--pl5.22.0_0.img
  /work/projects/singularity/TACC/biocontainers/bwameth_0.2.0--py36_1.img
  /work/projects/singularity/TACC/biocontainers/bwameth_0.2.0--py36_0.img
  /work/projects/singularity/TACC/biocontainers/bwa_0.7.13--1.img
  /work/projects/singularity/TACC/biocontainers/bwa_0.7.15--1.img
  /work/projects/singularity/TACC/biocontainers/bwa_0.7.16--pl5.22.0_0.img

To test the image interactively (from a compute node!) you can do something like the following:

.. code-block:: bash

  # get an interactive session
  idev
  # load the Singularity module
  module load tacc-singularity
  # explore the container
  singularity shell /work/projects/singularity/TACC/biocontainers/bwa_0.7.15--1.img

.. Note::

  If you run the container from your $WORK directory, Singularity will by default volume mount /work into the container, and all your $WORK files will be available.

From there, you are ready to incorporate "singularity exec" commands into your job submission scripts just like you would any other command.