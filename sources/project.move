module blockchainCertificate::CourseCertificate {

    use aptos_framework::signer;
    use aptos_std::option::{Option, some, none}; // Importing Option module

    /// Struct representing a course completion certificate.
    struct Certificate has key, store, copy {
        course_name: vector<u8>,     // Name of the course
        student_address: address,    // Address of the student receiving the certificate
    }

    /// Function to issue a new course certificate.
    public fun issue_certificate(admin: &signer, recipient: address, course_name: vector<u8>) {
        let certificate = Certificate {
            course_name,
            student_address: recipient,
        };
        move_to(admin, certificate);
    }

    /// Function to verify if a certificate exists for a student.
    public fun verify_certificate(owner: address): bool acquires Certificate {
        exists<Certificate>(owner)
    }

    /// Function to retrieve a certificate if it exists.
    public fun get_certificate(owner: address) acquires Certificate {
        if (exists<Certificate>(owner)) {
            let cert = borrow_global<Certificate>(owner);
             some(*cert);
        };
        
    }
}
