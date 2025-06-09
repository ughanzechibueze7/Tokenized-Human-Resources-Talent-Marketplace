;; Employer Verification Contract
;; Validates and manages employer organizations

(define-constant CONTRACT_OWNER tx-sender)
(define-constant ERR_NOT_AUTHORIZED (err u100))
(define-constant ERR_EMPLOYER_EXISTS (err u101))
(define-constant ERR_EMPLOYER_NOT_FOUND (err u102))
(define-constant ERR_INVALID_STATUS (err u103))

;; Data structures
(define-map employers
  { employer-id: uint }
  {
    company-name: (string-ascii 100),
    industry: (string-ascii 50),
    verified: bool,
    registration-date: uint,
    verifier: principal
  }
)

(define-map employer-principals
  { employer: principal }
  { employer-id: uint }
)

(define-data-var next-employer-id uint u1)

;; Public functions
(define-public (register-employer (company-name (string-ascii 100)) (industry (string-ascii 50)))
  (let ((employer-id (var-get next-employer-id)))
    (asserts! (is-none (map-get? employer-principals { employer: tx-sender })) ERR_EMPLOYER_EXISTS)
    (map-set employers
      { employer-id: employer-id }
      {
        company-name: company-name,
        industry: industry,
        verified: false,
        registration-date: block-height,
        verifier: CONTRACT_OWNER
      }
    )
    (map-set employer-principals { employer: tx-sender } { employer-id: employer-id })
    (var-set next-employer-id (+ employer-id u1))
    (ok employer-id)
  )
)

(define-public (verify-employer (employer-id uint))
  (begin
    (asserts! (is-eq tx-sender CONTRACT_OWNER) ERR_NOT_AUTHORIZED)
    (match (map-get? employers { employer-id: employer-id })
      employer-data
      (begin
        (map-set employers
          { employer-id: employer-id }
          (merge employer-data { verified: true, verifier: tx-sender })
        )
        (ok true)
      )
      ERR_EMPLOYER_NOT_FOUND
    )
  )
)

;; Read-only functions
(define-read-only (get-employer (employer-id uint))
  (map-get? employers { employer-id: employer-id })
)

(define-read-only (get-employer-by-principal (employer principal))
  (match (map-get? employer-principals { employer: employer })
    employer-info
    (map-get? employers { employer-id: (get employer-id employer-info) })
    none
  )
)

(define-read-only (is-verified-employer (employer-id uint))
  (match (map-get? employers { employer-id: employer-id })
    employer-data (get verified employer-data)
    false
  )
)
