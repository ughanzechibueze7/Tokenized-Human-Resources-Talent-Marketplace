# Tokenized Human Resources Talent Marketplace

A decentralized HR platform built on Stacks blockchain using Clarity smart contracts. This marketplace connects employers with verified talent through a transparent, blockchain-based system.

## Overview

The HR Talent Marketplace consists of five core smart contracts that work together to create a comprehensive talent management ecosystem:

1. **Employer Verification Contract** - Validates and manages employer organizations
2. **Talent Verification Contract** - Verifies talent credentials and skills
3. **Job Matching Contract** - Matches talent with employment opportunities
4. **Interview Coordination Contract** - Coordinates hiring interviews
5. **Performance Tracking Contract** - Tracks employee performance and reviews

## Features

### For Employers
- Register and verify company profiles
- Post job opportunities with skill requirements
- Review talent applications with match scoring
- Schedule and manage interviews
- Track employee performance and set goals
- Conduct performance reviews

### For Talent
- Register and verify professional profiles
- Add and showcase skills with proficiency levels
- Apply for job opportunities
- Participate in scheduled interviews
- Receive performance feedback and reviews
- Set and track professional goals

## Smart Contract Architecture

### Employer Verification Contract
\`\`\`clarity
;; Key functions:
- register-employer: Register a new employer
- verify-employer: Verify employer credentials
- get-employer: Retrieve employer information
- is-verified-employer: Check verification status
  \`\`\`

### Talent Verification Contract
\`\`\`clarity
;; Key functions:
- register-talent: Register new talent profile
- add-skill: Add skills with proficiency levels
- verify-talent: Verify talent credentials
- endorse-skill: Endorse talent skills
  \`\`\`

### Job Matching Contract
\`\`\`clarity
;; Key functions:
- post-job: Create new job posting
- apply-for-job: Submit job application
- update-application-status: Manage application status
- close-job: Close job posting
  \`\`\`

### Interview Coordination Contract
\`\`\`clarity
;; Key functions:
- schedule-interview: Schedule new interview
- complete-interview: Complete interview with rating
- cancel-interview: Cancel scheduled interview
- reschedule-interview: Reschedule interview time
  \`\`\`

### Performance Tracking Contract
\`\`\`clarity
;; Key functions:
- create-performance-review: Create performance review
- set-employee-goal: Set employee goals
- complete-goal: Mark goals as completed
- update-review-rating: Update review ratings
  \`\`\`

## Getting Started

### Prerequisites
- Stacks blockchain development environment
- Clarity CLI tools
- Node.js and npm for testing

### Installation

1. Clone the repository:
   \`\`\`bash
   git clone <repository-url>
   cd hr-talent-marketplace
   \`\`\`

2. Install dependencies:
   \`\`\`bash
   npm install
   \`\`\`

3. Run tests:
   \`\`\`bash
   npm test
   \`\`\`

### Deployment

Deploy contracts to Stacks testnet:
\`\`\`bash
# Deploy employer verification contract
clarinet deploy --testnet contracts/employer-verification.clar

# Deploy talent verification contract
clarinet deploy --testnet contracts/talent-verification.clar

# Deploy job matching contract
clarinet deploy --testnet contracts/job-matching.clar

# Deploy interview coordination contract
clarinet deploy --testnet contracts/interview-coordination.clar

# Deploy performance tracking contract
clarinet deploy --testnet contracts/performance-tracking.clar
\`\`\`

## Usage Examples

### Register as Employer
\`\`\`clarity
(contract-call? .employer-verification register-employer "Tech Corp" "Technology")
\`\`\`

### Register as Talent
\`\`\`clarity
(contract-call? .talent-verification register-talent "John Doe" "john@example.com" u5)
\`\`\`

### Post a Job
\`\`\`clarity
(contract-call? .job-matching post-job u1 "Senior Developer" "Full-stack development role" (list "JavaScript" "React" "Node.js") u100000)
\`\`\`

### Apply for Job
\`\`\`clarity
(contract-call? .job-matching apply-for-job u1 u1)
\`\`\`

## Testing

The project includes comprehensive tests using Vitest:

\`\`\`bash
npm test
\`\`\`

Tests cover:
- Contract deployment and initialization
- Employer and talent registration
- Job posting and application workflows
- Interview scheduling and management
- Performance tracking functionality

## Security Considerations

- All contracts include proper authorization checks
- Input validation for all public functions
- Error handling with descriptive error codes
- Principal-based access control

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For questions and support, please open an issue in the GitHub repository.
\`\`\`

## Roadmap

- [ ] Integration with external credential verification services
- [ ] Advanced matching algorithms based on skills and experience
- [ ] Reputation system for employers and talent
- [ ] Token-based incentive mechanisms
- [ ] Mobile application interface
- [ ] Integration with traditional HR systems
  \`\`\`

