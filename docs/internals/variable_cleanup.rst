.. index: variable cleanup

*********************
Cleaning Up Variables
*********************

Ultimately, all values in the EVM are stored in 256 bit words.
Thus, when the type of a value has less than 256 bits,
in some cases the remaining bits must be cleaned.
The Solidity compiler is designed to clean such remaining bits before any operations
that might be adversely affected by the potential garbage in the remaining bits.
For example, before writing a value to  memory, the remaining bits need
to be cleared because the memory contents can be used for computing
hashes or sent as the data of a message call.  Similarly, before
storing a value in the storage, the remaining bits need to be cleaned
because otherwise the garbled value can be observed.

Note that access via inline assembly is not considered such an operation:
If you use inline assembly to access Solidity variables
shorter than 256 bits, the compiler does not guarantee that
the value is properly cleaned up.

Moreover, we do not clean the bits if the immediately
following operation is not affected.  For instance, since any non-zero
value is considered ``true`` by ``JUMPI`` instruction, we do not clean
the boolean values before they are used as the condition for
``JUMPI``.

In addition to the design principle above, the Solidity compiler
cleans input data when it is loaded onto the stack.

The following table describes the rules applied for valid and invalid values of different types,
where ``higher bits`` refers to the remaining bits in case the type has less than 256 bits.

+---------------+---------------+-------------------------+
|Type           |Valid Values   |Cleanup of Invalid Values|
+===============+===============+=========================+
|enum of n      |0 until n - 1  |throws exception         |
|members        |               |                         |
+---------------+---------------+-------------------------+
|bool           |0 or 1         |results in 1             |
+---------------+---------------+-------------------------+
|signed integers|higher bits    |currently silently       |
|               |set to the     |signextends to a valid   |
|               |sign bit       |value, i.e. all higher   |
|               |               |bits are set to the sign |
|               |               |bit; may throw an        |
|               |               |exception in the future  |
+---------------+---------------+-------------------------+
|unsigned       |higher bits    |currently silently masks |
|integers       |zeroed         |to a valid value, i.e.   |
|               |               |all higher bits are set  |
|               |               |to zero; may throw an    |
|               |               |exception in the future  |
+---------------+---------------+-------------------------+
